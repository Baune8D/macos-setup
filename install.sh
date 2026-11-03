#!/bin/zsh

brewfile="${0:a:h}/Brewfile"
if [ ! -f "$brewfile" ]; then
    echo "No Brewfile next to install.sh. Download the whole repository and run install.sh from it." >&2
    exit 1
fi

# Install Rosetta 2
softwareupdate --install-rosetta

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' | tee -a ~/.profile ~/.zprofile > /dev/null
source ~/.zprofile # Reload zsh config
brew analytics off

# Install the Homebrew packages, App Store apps and VS Code extensions in the Brewfile
brew bundle install --file "$brewfile"

# Let the system Java wrappers find OpenJDK
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Install rbenv and Ruby
echo 'eval "$(rbenv init -)"' | tee -a ~/.profile ~/.zprofile > /dev/null
source ~/.zprofile # Reload zsh config
RUBY_VERSION="3.2.2"
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION

# Install pyenv and Python
echo 'export PYENV_ROOT="$HOME/.pyenv"' | tee -a ~/.profile ~/.zprofile > /dev/null
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' | tee -a ~/.profile ~/.zprofile > /dev/null
echo 'eval "$(pyenv init -)"' | tee -a ~/.profile ~/.zprofile > /dev/null
source ~/.zprofile # Reload zsh config
PYTHON_VERSION="3.11.5"
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

# Install Node.js LTS with fnm
echo 'eval "$(fnm env --use-on-cd --shell zsh)"' >> ~/.zprofile
echo 'eval "$(fnm env --use-on-cd --shell bash)"' >> ~/.profile
source ~/.zprofile # Reload zsh config
fnm install --lts

# Install PHP, Composer and Laravel
phpbrew init
echo '[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc' | tee -a ~/.profile ~/.zprofile > /dev/null
source ~/.zprofile # Reload zsh config
PHP_VERSION="8.1.23"
phpbrew install $PHP_VERSION
phpbrew switch php-$PHP_VERSION
echo 'export PATH=$PATH:$HOME/.composer/vendor/bin' >> ~/.zprofile
source ~/.zprofile # Reload zsh config
echo export COMPOSER_MEMORY_LIMIT=-1 >> ~/.zshrc
echo "alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'" >> ~/.zshrc # Create Laravel Sail alias
source ~/.zshrc # Reload zsh config

# Starship prompt
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
source ~/.zshrc # Reload zsh config

# Zsh plugins
echo source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh >> ~/.zshrc
echo source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >> ~/.zshrc
source ~/.zshrc # Reload zsh config

# Alias system tools
echo 'alias ls="eza"' >> ~/.zshrc
echo 'alias kubectl="kubecolor"' >> ~/.zshrc

# Neovim as the default editor
echo 'export EDITOR="nvim"' >> ~/.zshrc

# Install NUKE
echo 'export PATH=$PATH:$HOME/.dotnet/tools' >> ~/.zprofile
source ~/.zprofile # Reload zsh config
dotnet tool install Nuke.GlobalTool --global

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
