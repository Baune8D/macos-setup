#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Essentials
brew install git
exec $SHELL -l # Refresh shell to pick up new git version
brew install zsh
exec $SHELL -l # Refresh shell to pick up new zsh version

# Setup shell (Oh My Zsh)
compaudit | xargs chmod g-w,o-w # Fix insecure zsh folders by removing group write permission
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install zsh-autosuggestions
echo source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh >> ~/.zshrc
brew install zsh-syntax-highlighting
echo source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >> ~/.zshrc
source .zshrc # Reload zsh config

# Install rbenv and update Ruby
brew install rbenv
echo 'eval "$(rbenv init -)"' | tee -a ~/.bash_profile ~/.zshrc > /dev/null
source .zshrc # Reload zsh config
LATEST_RUBY_VERSION="$(rbenv install -l | grep -v - | tail -1 | tr -d '[[:space:]]')"
rbenv install $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION
exec $SHELL -l # Refresh shell to pick up new ruby version

# Install App Store apps
brew install mas
mas install 497799835 # Xcode
sudo xcodebuild -license accept # Accept Xcode license
mas install 425424353 # The Unarchiver
mas install 1295203466 # Microsoft Remote Desktop
mas install 1262957439 # Textual IRC Client
mas install 803453959 # Slack
mas install 1063631769 # Medis
mas install 1480068668 # Messenger
mas install 1147396723 # WhatsApp
mas install 1451685025 # WireGuard

# Install Homebrew
brew install cmake
brew install gettext
brew install neovim
brew install tmux

# Install Node Version Manager, zsh-nvm, Node.js and Yarn
git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm
echo source ~/.zsh-nvm/zsh-nvm.plugin.zsh >> ~/.zshrc
source .zshrc # Reload zsh config
nvm install --lts
brew install yarn

# Install Java (OpenJDK)
brew cask install openjdk
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk # Make OpenJDK visible to the system Java wrappers

# Install Casks (drivers)
brew cask install homebrew/cask-drivers/logitech-options
brew cask install caldigit-thunderbolt-charging
brew cask install paragon-ntfs

# Install Casks (languages)
brew cask install powershell
brew cask install mono-mdk
brew cask install dotnet-sdk

# Install Casks (virtualization)
brew cask install vagrant
brew cask install vagrant-manager
brew cask install vmware-fusion
brew cask install vagrant-vmware-utility
brew cask install docker
brew cask install parallels
brew cask install virtualbox
brew cask install virtualbox-extension-pack

# Install Casks (development)
brew cask install redis
brew cask install ngrok
brew cask install github
brew cask install charles
brew cask install postman
brew cask install mysqlworkbench
brew cask install azure-data-studio
brew cask install visual-studio-code
brew cask install rider

# Install Casks (other)
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
brew cask install zoom

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

# Install Ruby Gems
gem install bundler
gem install ultrahook

# Open folders with additional manual installers
open /usr/local/Caskroom/paragon-ntfs
