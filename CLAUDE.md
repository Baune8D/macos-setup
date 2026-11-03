# macos-setup

The script that sets up a new Mac (Apple silicon) for its owner.

- `install.sh`: a zsh script (`#!/bin/zsh`), so it can reload `~/.zprofile` and `~/.zshrc` after each step. It installs Rosetta and Homebrew, runs `brew bundle install` on the Brewfile next to it (found with `${0:a:h}`), then sets up what Homebrew doesn't: the OpenJDK link, the Ruby, Python, Node.js and PHP versions (rbenv, pyenv, fnm, phpbrew), the dotfile lines, NUKE, Claude Code, Vagrant plugins, Composer packages and gems.
- Dotfile lines go through `add_line`, which only appends a line that isn't there yet. Every other step skips what's already installed, so the script can be run again. Keep both true for new steps.
- `Brewfile`: the formulae, casks, App Store apps (`mas`) and VS Code extensions, grouped by purpose. Use each package's current name (not an alias or old token) and give third-party tap entries `trusted: true`.
- `check-brewfile.sh`: checks that every Brewfile entry can still be installed. Bash, read-only.
- The README lists what gets installed and the manual steps. Keep it in step with the script and the Brewfile.

## Workflow

- Conventional commits (`feat:`, `fix:`, `chore(deps):`, `ci:`, `build:`, `docs:`), one commit per concern, directly on `main`.
- Only push, tag, publish or edit GitHub releases when asked.
- Commit messages must be accurate. If one turns out to be wrong before it is pushed, reword it (replay the commits and check that the tree is unchanged). Never rewrite pushed history.

## Dependencies

- Before adding or replacing an entry, check it with `brew info --json=v2` (deprecated, disabled, renamed), the iTunes lookup API (`https://itunes.apple.com/lookup?id=<id>`) for App Store apps, or the Marketplace for VS Code extensions. Then run `./check-brewfile.sh`.
- Ruby and PHP are pinned to a release in install.sh; Python is a minor version that pyenv resolves to its latest release (rbenv can't resolve prefixes). Use a supported series, and keep the build dependencies in the Brewfile in line with ruby-build's and pyenv's wikis.
- Dependabot updates the GitHub Actions weekly on Monday with a 7-day cooldown, in one grouped pull request.

## Testing

- **Never run `install.sh` or `brew bundle install` on the machine you're working on.** They install and upgrade software and change the dotfiles of the person using it. Check changes statically instead.
- CI runs `zsh -n install.sh` (shellcheck doesn't support zsh), `shellcheck check-brewfile.sh` and, on a macOS runner, `check-brewfile.sh` after tapping and trusting the Brewfile's taps. It also runs every Monday, so an entry that goes away fails CI without a push. Run the same checks before committing; check-brewfile.sh only reads.
- check-brewfile.sh can't tell when a package is merely end-of-life or no longer maintained (it passed the .NET 6 SDK, Vetur and the Docker extension), so check that by hand too.
- A full run needs a new Mac and takes hours, so the script itself is never run in CI. Say so when a change hasn't been run on a machine.
