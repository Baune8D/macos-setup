#!/bin/zsh

brewfile="${0:a:h}/Brewfile"
if [ ! -f "$brewfile" ]; then
    echo "No Brewfile next to install.sh. Download the whole repository and run install.sh from it." >&2
    exit 1
fi

# Add a line to each of the files unless it's already there, so running the
# script again doesn't add it twice
add_line() {
    local line=$1 file
    shift
    for file in "$@"; do
        touch "$file"
        grep -qxF -- "$line" "$file" && continue
        # Start on a new line if the file doesn't end with one
        if [ -s "$file" ] && [ -n "$(tail -c 1 "$file")" ]; then
            echo >> "$file"
        fi
        printf '%s\n' "$line" >> "$file"
    done
}

# Install Rosetta 2
if ! arch -x86_64 /usr/bin/true 2> /dev/null; then
    softwareupdate --install-rosetta
fi

# Install Homebrew
if [ ! -x /opt/homebrew/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
add_line 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.profile ~/.zprofile
source ~/.zprofile # Reload zsh config
brew analytics off

# Install the Homebrew packages, App Store apps and VS Code extensions in the Brewfile
brew bundle install --file "$brewfile"

# Let the system Java wrappers find OpenJDK
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Install rbenv and Ruby
add_line 'eval "$(rbenv init -)"' ~/.profile ~/.zprofile
source ~/.zprofile # Reload zsh config
RUBY_VERSION="3.4.12"
rbenv install --skip-existing "$RUBY_VERSION"
rbenv global "$RUBY_VERSION"

# Install pyenv and Python
add_line 'export PYENV_ROOT="$HOME/.pyenv"' ~/.profile ~/.zprofile
add_line 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' ~/.profile ~/.zprofile
add_line 'eval "$(pyenv init -)"' ~/.profile ~/.zprofile
source ~/.zprofile # Reload zsh config
PYTHON_VERSION="3.14" # pyenv installs the latest 3.14 release
pyenv install --skip-existing "$PYTHON_VERSION"
pyenv global "$PYTHON_VERSION"

# Install Node.js LTS with fnm
add_line 'eval "$(fnm env --use-on-cd --shell zsh)"' ~/.zprofile
add_line 'eval "$(fnm env --use-on-cd --shell bash)"' ~/.profile
source ~/.zprofile # Reload zsh config
fnm install --lts

# Set up Composer and Laravel. PHP is Homebrew's latest, from the Brewfile.
add_line 'export PATH=$PATH:$HOME/.composer/vendor/bin' ~/.zprofile
source ~/.zprofile # Reload zsh config
add_line 'export COMPOSER_MEMORY_LIMIT=-1' ~/.zshrc
add_line "alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'" ~/.zshrc # Laravel Sail alias
source ~/.zshrc # Reload zsh config

# Starship prompt
add_line 'eval "$(starship init zsh)"' ~/.zshrc
source ~/.zshrc # Reload zsh config

# Zsh plugins
add_line 'source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh' ~/.zshrc
add_line 'source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ~/.zshrc
source ~/.zshrc # Reload zsh config

# Alias system tools
add_line 'alias ls="eza"' ~/.zshrc
add_line 'alias kubectl="kubecolor"' ~/.zshrc

# Neovim as the default editor
add_line 'export EDITOR="nvim"' ~/.zshrc

# Install NUKE
add_line 'export PATH=$PATH:$HOME/.dotnet/tools' ~/.zprofile
source ~/.zprofile # Reload zsh config
if ! dotnet tool list --global | grep -qi '^nuke\.globaltool '; then
    dotnet tool install Nuke.GlobalTool --global
fi

# Install Claude Code with its official installer. It keeps itself up to date.
add_line 'export PATH="$HOME/.local/bin:$PATH"' ~/.profile ~/.zprofile
if [ ! -x ~/.local/bin/claude ]; then
    curl -fsSL https://claude.ai/install.sh | bash
fi

# Install Vagrant plugins
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-parallels
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-vmware-desktop

# Install Composer packages
composer global require laravel/installer

# Install Ruby gems
gem install bundler
gem install jekyll
gem install ultrahook

# Open the folder containing the NTFS for Mac installer, which has to be run by hand
open /opt/homebrew/Caskroom/paragon-ntfs

print -P "%F{green}All done! Restart your terminal, then finish the manual steps in the README.%f"
