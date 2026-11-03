#!/usr/bin/env bash
# Checks that everything in the Brewfile can still be installed:
#
# - the taps are tapped, so their formulae can be looked up,
# - formulae and casks exist under the name used and aren't deprecated or
#   disabled (renamed ones are reported with their new name),
# - App Store apps are still in the store,
# - VS Code extensions are on the Marketplace and VS Code doesn't list them
#   as deprecated or malicious.
#
# It only reads: it doesn't tap, trust or install anything. Tap and trust the
# Brewfile's taps before running it on a machine that doesn't have them, as CI
# does.
#
# Usage: ./check-brewfile.sh [Brewfile]
set -euo pipefail

brewfile=${1:-"$(dirname "${BASH_SOURCE[0]}")/Brewfile"}
export HOMEBREW_NO_AUTO_UPDATE=1
problems=0
checked=0

problem() {
    if [ -n "${GITHUB_ACTIONS:-}" ]; then
        echo "::error file=Brewfile::$1"
    else
        echo "error: $1"
    fi
    problems=$((problems + 1))
}

list() {
    brew bundle list "--$1" --file "$brewfile"
}

for tap in $(list tap); do
    checked=$((checked + 1))
    if [ "$(brew tap-info --json "$tap" | jq -r '.[0].installed')" != true ]; then
        problem "tap $tap isn't tapped, so its formulae can't be checked: brew tap $tap"
    fi
done

# Prints a line for each problem with a formula or cask, from its brew info JSON
package_problems() {
    # brew bundle list leaves the tap out of cask names, so compare without it
    jq -r --arg type "$1" --arg name "$2" '
        def short: split("/") | last;
        (.formulae + .casks)[0]
        | (.full_name // .full_token) as $current
        | ((.deprecation_replacement_formula // .deprecation_replacement_cask
            // .disable_replacement_formula // .disable_replacement_cask)
            | if . then ", use \(.)" else "" end) as $use
        | (if ($current | short) != ($name | short) then "\($type) \($name) is now called \($current)" else empty end),
          (if .disabled then "\($type) \($name) is disabled: \(.disable_reason) (\(.disable_date))\($use)"
           elif .deprecated then "\($type) \($name) is deprecated: \(.deprecation_reason) (\(.deprecation_date))\($use)"
           else empty end)'
}

for type in formula cask; do
    for name in $(list "$type"); do
        checked=$((checked + 1))
        if ! json=$(brew info --json=v2 "--$type" "$name" 2> /dev/null); then
            problem "$type $name doesn't exist: $(brew info "--$type" "$name" 2>&1 | head -1)"
            continue
        fi
        while IFS= read -r line; do
            [ -n "$line" ] && problem "$line"
        done < <(package_problems "$type" "$name" <<< "$json")
    done
done

# brew bundle list prints App Store apps by name, so read the IDs from the Brewfile
while IFS='|' read -r id name; do
    checked=$((checked + 1))
    if ! count=$(curl -fsS --retry 5 "https://itunes.apple.com/lookup?id=$id" | jq -r '.resultCount'); then
        problem "App Store app $name ($id) couldn't be looked up"
    elif [ "$count" = 0 ]; then
        problem "App Store app $name ($id) isn't in the App Store"
    fi
done < <(sed -nE 's/^[[:space:]]*mas[[:space:]]+"([^"]+)",[[:space:]]*id:[[:space:]]*([0-9]+).*/\2|\1/p' "$brewfile")

extensions=$(list vscode | tr '[:upper:]' '[:lower:]')
if [ -n "$extensions" ]; then
    query=$(jq -n --arg ids "$extensions" \
        '{filters: [{criteria: ($ids | split("\n") | map({filterType: 7, value: .}))}], flags: 0}')
    marketplace=true
    if ! found=$(curl -fsS --retry 5 -X POST https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery \
        -H 'Content-Type: application/json' -H 'Accept: application/json;api-version=7.2-preview.1' -d "$query" |
        jq -r '.results[0].extensions[] | "\(.publisher.publisherName).\(.extensionName)" | ascii_downcase'); then
        problem "the VS Code Marketplace couldn't be queried"
        marketplace=false
    fi
    # VS Code's own lists of deprecated and malicious extensions
    lists=true
    if ! vscode_lists=$(curl -fsSL --retry 5 https://main.vscode-cdn.net/extensions/marketplace.json); then
        problem "VS Code's lists of deprecated and malicious extensions couldn't be downloaded"
        lists=false
    fi
    for extension in $extensions; do
        checked=$((checked + 1))
        if $marketplace && ! grep -qxF "$extension" <<< "$found"; then
            problem "VS Code extension $extension isn't on the Marketplace"
        fi
        $lists || continue
        while IFS= read -r line; do
            problem "$line"
        done < <(jq -r --arg id "$extension" '
            (.deprecated | to_entries[] | select(.key | ascii_downcase == $id) | .value) as $deprecated
            | "VS Code extension \($id) is deprecated"
              + (if ($deprecated | type) == "object" and $deprecated.extension then ", use \($deprecated.extension.id)" else "" end)' \
            <<< "$vscode_lists")
        if jq -e --arg id "$extension" '.malicious | map(ascii_downcase) | index($id)' <<< "$vscode_lists" > /dev/null; then
            problem "VS Code extension $extension is on VS Code's list of malicious extensions"
        fi
    done
fi

if [ "$problems" -gt 0 ]; then
    echo "$problems problem(s) in $checked Brewfile entries"
    exit 1
fi
echo "All $checked Brewfile entries can be installed"
