#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Essentials
brew install git
exec $SHELL -l # Refresh shell to pick up new git version
brew install zsh
exec $SHELL -l # Refresh shell to pick up new zsh version
brew install mas

# Tap into additional Homebrew channels
brew tap homebrew/cask-fonts

# Setup shell (oh-my-zsh)
brew install zsh-completions
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

# Install Ruby Gems
gem install ultrahook

# Install App Store apps
mas install 497799835 # Xcode
sudo xcodebuild -license accept # Accept Xcode license
mas install 425424353 # The Unarchiver
mas install 1295203466 # Microsoft Remote Desktop
mas install 1262957439 # Textual IRC Client
mas install 803453959 # Slack
mas install 1063631769 # Medis - GUI for Redis

# Install Homebrew apps
brew install cmake
brew install gettext
brew install neovim
brew install tmux

# Install Casks (drivers)
brew cask install logitech-options
brew cask install paragon-ntfs

# Install Casks (languages)
brew cask install java
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

# Install Vagrant plugins
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-parallels
vagrant plugin install vagrant-vmware-desktop

# Install Node Version Manager, zsh-nvm, Node.js and Yarn
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm
echo source ~/.zsh-nvm/zsh-nvm.plugin.zsh >> ~/.zshrc
source .zshrc # Reload zsh config
nvm install --lts
brew install yarn

# Install Visual Studio Code extensions
code --install-extension ms-dotnettools.csharp
code --install-extension editorconfig.editorconfig
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension stylelint.vscode-stylelint

# Install Spacemacs
brew tap d12frosted/emacs-plus
brew install emacs-plus
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
brew cask install font-source-code-pro
ln -s /usr/local/Cellar/emacs-plus/*/Emacs.app/ /Applications/

# Install VirtualBox and inform about manual steps
brew cask install virtualbox
echo -e "\x1b[1;32mMake sure to allow the VirtualBox extension now!\x1b[0m"
echo -e "\x1b[1;32mThen manually run the following commands:\x1b[0m"
echo brew cask install virtualbox
echo brew cask install virtualbox-extension-pack

# Open folders with additional manual installers
open /usr/local/Caskroom/adobe-creative-cloud
open /usr/local/Caskroom/paragon-ntfs
