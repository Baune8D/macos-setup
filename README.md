# macOS setup

[![CI](https://github.com/Baune8D/macos-setup/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/Baune8D/macos-setup/actions/workflows/ci.yml)

My script for setting up a new Mac: Homebrew with the packages, apps and VS Code extensions in the [Brewfile](Brewfile), version managers for Ruby, Python, Node.js and PHP, a zsh setup with Starship, and Claude Code.

## Requirements

- A Mac with Apple silicon. The script uses Homebrew's `/opt/homebrew` prefix.
- An admin account. Homebrew, the OpenJDK link and several apps ask for your password.
- Signed in to the App Store. [mas](https://github.com/mas-cli/mas) gets the free App Store apps but can't buy apps, so buy Medis in the App Store first.

## Usage

A new Mac has no git, so download the repository as a ZIP:

1. Download [main.zip](https://github.com/Baune8D/macos-setup/archive/refs/heads/main.zip). Safari unzips it into Downloads as `macos-setup-main`.
2. In Terminal, run:

   ```sh
   ~/Downloads/macos-setup-main/install.sh
   ```

3. Restart the terminal when it says "All done!", and do the [manual steps](#manual-steps).

install.sh needs the Brewfile next to it, so run it from the whole download, not on its own. It's safe to run again: it skips what's already installed, upgrades the Homebrew packages and only adds the dotfile lines that aren't there yet.

## What it does

In order:

1. Installs Rosetta 2 and Homebrew, and turns Homebrew's analytics off.
2. Installs everything in the [Brewfile](Brewfile) with `brew bundle install`:
   - **Command-line tools:** Git, eza, kubecolor, mas, Neovim, NuGet, Packer, tmux, zsh, Starship and the zsh plugins, and the .NET SDK.
   - **Version managers:** rbenv, pyenv, fnm and phpbrew, with what they need to build Ruby, Python and PHP, and Composer.
   - **Apps:** balenaEtcher, Bluesnooze, Charles, Discord, Docker Desktop, Firefox, ForkLift, the Google Cloud CLI, GitHub Desktop, Google Chrome, Google Drive, ImageOptim, iTerm2, JetBrains Toolbox, LibreOffice, MAMP, Mono, MySQL Workbench, ngrok, Parallels Desktop, Plex, Postman, PowerShell, Raspberry Pi Imager, RealVNC Connect Viewer, SABnzbd, SD Formatter, Spotify, Steam, Textual, Vagrant and the Vagrant VMware Utility, VirtualBox, VS Code, VLC, Warp, Zoom and TeamViewer, and the Fira Code Nerd Font.
   - **Drivers:** Logi Options+, and extFS and NTFS for Mac by Paragon.
   - **App Store apps:** Slack, Medis, WhatsApp, Windows App and WireGuard.
   - **VS Code extensions:** Claude Code, C#, Container Tools, Dev Containers, EditorConfig, ESLint, PHP Debug, PowerShell, Prettier, SQL Server (mssql), Stylelint and Vue (Official).
3. Links Homebrew's OpenJDK so that the system's `java` finds it.
4. Installs Ruby 3.4.12 with rbenv, the latest Python 3.14 with pyenv, the latest Node.js LTS with fnm and PHP 8.4.27 with phpbrew, and makes them the defaults.
5. Sets up the shell:
   - `~/.zprofile` (and `~/.profile`, for bash): Homebrew, rbenv, pyenv, fnm and phpbrew, and the Composer, .NET tools and Claude Code folders on `PATH`.
   - `~/.zshrc`: the Starship prompt, zsh-autosuggestions, zsh-syntax-highlighting, `ls` as eza, `kubectl` as kubecolor, Neovim as `EDITOR`, a `sail` alias for Laravel Sail and `COMPOSER_MEMORY_LIMIT=-1`.
6. Installs NUKE (`dotnet tool install --global Nuke.GlobalTool`) and Claude Code, with its [official installer](https://code.claude.com/docs/en/setup). Claude Code keeps itself up to date.
7. Installs the Vagrant plugins vagrant-hostmanager, vagrant-parallels, vagrant-reload and vagrant-vmware-desktop, the Laravel installer with Composer, and the bundler, jekyll and ultrahook gems.
8. Opens the folder with the NTFS for Mac installer.

## Manual steps

- Run the NTFS for Mac installer, `FSInstaller.app`, in the folder the script opens.
- extFS and NTFS for Mac need a kernel extension. If they don't work, allow it in System Settings > Privacy & Security.
- Restart the Mac to finish installing Logi Options+.
- Give TeamViewer the access it asks for when it first starts.
- VMware Fusion is no longer in Homebrew. For the vagrant-vmware-desktop provider, download it from [Broadcom](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion), which needs a free Broadcom account.
- Textual is now sold on [textualapp.com](https://www.textualapp.com) instead of the App Store, which also explains how to move an App Store purchase over.

## Keeping the Brewfile current

[check-brewfile.sh](check-brewfile.sh) checks that every Brewfile entry can still be installed. It reports formulae and casks that are gone, renamed, deprecated or disabled, App Store apps that left the store, and VS Code extensions that left the Marketplace or are deprecated. It only reads, so it's safe to run on any Mac:

```sh
./check-brewfile.sh
```

CI runs it on every push and every Monday.
