#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

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
echo 'eval "$(rbenv init -)"' | tee -a ~/.bash_profile ~/.zshrc > /dev/null
source .zshrc # Reload zsh config
LATEST_RUBY_VERSION="$(rbenv install -l | grep -v - | tail -1 | tr -d '[[:space:]]')"
rbenv install $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION
exec $SHELL -l # Refresh shell to pick up new Ruby version

# Install zsh-nvm, nvm, Node.js LTS and Yarn
git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm
echo source ~/.zsh-nvm/zsh-nvm.plugin.zsh >> ~/.zshrc
source .zshrc # Reload zsh config
nvm install --lts
brew install yarn

# Install ZSH plugins
brew install zsh-autosuggestions
echo source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh >> ~/.zshrc
brew install zsh-syntax-highlighting
echo source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >> ~/.zshrc
source .zshrc # Reload zsh config

# Install App Store apps
brew install mas
printf "Please open App Store and sign in before proceeding " && read
mas install 497799835 # Xcode
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer # Use full Xcode instead of CLT
sudo xcodebuild -license accept # Accept Xcode license
mas install 425424353 # The Unarchiver
mas install 1295203466 # Microsoft Remote Desktop
mas install 1262957439 # Textual IRC Client
mas install 803453959 # Slack
mas install 1063631769 # Medis
mas install 1480068668 # Messenger
mas install 1147396723 # WhatsApp
mas install 1451685025 # WireGuard

# Install Homebrew packages
brew install cmake
brew install neovim
brew install tmux

# Install PHP and Composer
brew install php
exec $SHELL -l # Refresh shell to pick up new PHP version
brew install composer
echo export COMPOSER_MEMORY_LIMIT=-1 >> ~/.zshrc

# Install Java (OpenJDK)
brew cask install openjdk
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk # Make OpenJDK visible to the system Java wrappers

# Install Casks (Drivers)
brew cask install homebrew/cask-drivers/logitech-options
brew cask install caldigit-thunderbolt-charging
brew cask install paragon-ntfs

# Install Casks (Frameworks)
brew cask install powershell
brew cask install mono-mdk
brew cask install dotnet-sdk

# Install Casks (Virtualization)
brew cask install vagrant
brew cask install vagrant-manager
brew cask install vmware-fusion
brew cask install vagrant-vmware-utility
brew cask install docker
brew cask install parallels
brew cask install virtualbox
brew cask install virtualbox-extension-pack

# Install Casks (Development)
brew cask install redis
brew cask install ngrok
brew cask install github
brew cask install charles
brew cask install postman
brew cask install mamp
brew cask install mysqlworkbench
brew cask install azure-data-studio
brew cask install visual-studio-code
brew cask install rider
brew cask install phpstorm
brew cask install intellij-idea-ce

# Install Casks
brew cask install adobe-creative-cloud
brew cask install vnc-viewer
brew cask install forklift
brew cask install google-chrome
brew cask install firefox
brew cask install sabnzbd
brew cask install steam
brew cask install dropbox
brew cask install skype
brew cask install gitter
brew cask install spotify
brew cask install iterm2
brew cask install imageoptim
brew cask install balenaetcher
brew cask install discord
brew cask install sdformatter
brew cask install teamviewer
brew cask install vlc
brew cask install megasync
brew cask install google-backup-and-sync
brew cask install onecast
brew cask install microsoft-teams
brew cask install zoomus
brew cask install plex-media-player

# Install Vagrant plugins
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-parallels
vagrant plugin install vagrant-vmware-desktop

# Install Visual Studio Code extensions
code --install-extension ms-dotnettools.csharp
code --install-extension editorconfig.editorconfig
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension stylelint.vscode-stylelint
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers
code --install-extension octref.vetur

# Install Ruby gems
gem install bundler
gem install ultrahook

# Open folders containing manual installers
open /usr/local/Caskroom/paragon-ntfs
