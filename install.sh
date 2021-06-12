#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Tap into additional repositories
brew tap homebrew/cask-drivers

# Install Xcode
brew install mas
printf "Please open App Store and sign in before proceeding " && read
mas install 497799835 # Xcode
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer # Use full Xcode instead of CLT
sudo xcodebuild -license accept # Accept Xcode license

# Install Essentials
brew install git
exec $SHELL -l # Refresh shell to pick up new git version
brew install zsh
exec $SHELL -l # Refresh shell to pick up new zsh version

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
compaudit | xargs chmod g-w,o-w # Fix insecure zsh folders by removing group and others write permission

# Install rbenv and update Ruby
brew install rbenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' | tee -a ~/.profile ~/.zprofile > /dev/null
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' | tee -a ~/.profile ~/.zprofile > /dev/null
echo 'eval "$(pyenv init --path)"' | tee -a ~/.profile ~/.zprofile > /dev/null
echo 'eval "$(rbenv init -)"' | tee -a ~/.bash_profile ~/.zshrc > /dev/null
source ~/.zshrc # Reload zsh config
LATEST_RUBY_VERSION="$(rbenv install -l | grep -v - | tail -1 | tr -d '[[:space:]]')"
rbenv install $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION
exec $SHELL -l # Refresh shell to pick up new Ruby version

# Install pyenv and update Python
brew install pyenv
echo 'eval "$(pyenv init -)"' | tee -a ~/.bash_profile ~/.zshrc > /dev/null
source ~/.zshrc # Reload zsh config
LATEST_PYTHON_VERSION="$(pyenv install -l | grep -v - | tail -1 | tr -d '[[:space:]]')"
pyenv install $LATEST_PYTHON_VERSION
pyenv global $LATEST_PYTHON_VERSION
exec $SHELL -l # Refresh shell to pick up new Python version

# Install zsh-nvm, nvm, Node.js LTS and Yarn
git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm
echo source ~/.zsh-nvm/zsh-nvm.plugin.zsh >> ~/.zshrc
source ~/.zshrc # Reload zsh config
nvm install --lts
brew install yarn

# Install Zsh plugins
brew install zsh-autosuggestions
echo source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh >> ~/.zshrc
brew install zsh-syntax-highlighting
echo source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >> ~/.zshrc
source ~/.zshrc # Reload zsh config

# Install App Store apps
mas install 425424353 # The Unarchiver
mas install 803453959 # Slack
mas install 1063631769 # Medis
mas install 1147396723 # WhatsApp
mas install 1262957439 # Textual IRC Client
mas install 1295203466 # Microsoft Remote Desktop
mas install 1451685025 # WireGuard
mas install 1480068668 # Messenger

# Install Homebrew packages
brew install cmake
brew install neovim
brew install tmux

# Install PHP and Composer
brew install php
exec $SHELL -l # Refresh shell to pick up new PHP version
brew install composer
echo export COMPOSER_MEMORY_LIMIT=-1 >> ~/.zshrc
echo export PATH='$PATH':/Users/$(whoami)/.composer/vendor/bin >> ~/.zshrc
source ~/.zshrc # Reload zsh config
composer global require laravel/installer

# Install .NET
brew install --cask dotnet-sdk
echo export PATH='$PATH':/Users/$(whoami)/.dotnet/tools >> ~/.zshrc
source ~/.zshrc # Reload zsh config
dotnet tool install Nuke.GlobalTool --global

# Install Casks
brew install --cask adobe-creative-cloud
brew install --cask adoptopenjdk
brew install --cask azure-data-studio
brew install --cask balenaetcher
brew install --cask charles
brew install --cask clion
brew install --cask discord
brew install --cask docker
brew install --cask dropbox
brew install --cask firefox
brew install --cask forklift
brew install --cask github
brew install --cask gitter
brew install --cask google-backup-and-sync
brew install --cask google-chrome
brew install --cask imageoptim
brew install --cask intellij-idea
brew install --cask iterm2
brew install --cask mamp
brew install --cask megasync
brew install --cask microsoft-teams
brew install --cask mono-mdk
brew install --cask mysqlworkbench
brew install --cask ngrok
brew install --cask onecast
brew install --cask paragon-ntfs
brew install --cask parallels
brew install --cask phpstorm
brew install --cask plex
brew install --cask postman
brew install --cask powershell
brew install --cask raspberry-pi-imager
brew install --cask redis
brew install --cask rider
brew install --cask sabnzbd
brew install --cask sdformatter
brew install --cask skype
brew install --cask spotify
brew install --cask steam
brew install --cask vagrant
brew install --cask vagrant-manager
brew install --cask vagrant-vmware-utility
brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask vmware-fusion
brew install --cask vnc-viewer
brew install --cask webstorm
brew install --cask zoom

# Install Vagrant plugins
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-parallels
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-vmware-desktop

# Install Visual Studio Code extensions
code --install-extension dbaeumer.vscode-eslint
code --install-extension editorconfig.editorconfig
code --install-extension esbenp.prettier-vscode
code --install-extension felixfbecker.php-debug
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-dotnettools.csharp
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode.powershell
code --install-extension octref.vetur
code --install-extension stylelint.vscode-stylelint

# Install Ruby gems
gem install bundler
gem install jekyll
gem install ultrahook

# Install Casks requiring extra intervention
brew install --cask caldigit-thunderbolt-charging
brew install --cask logitech-options
brew install --cask teamviewer
brew install --cask virtualbox
brew install --cask virtualbox-extension-pack

# Open folders containing manual installers
open /usr/local/Caskroom/paragon-ntfs
