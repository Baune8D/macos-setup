#!/bin/bash

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Setup shell (oh-my-zsh)
brew install zsh zsh-completions
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install zsh-autosuggestions
echo source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh >> ~/.zshrc
brew install zsh-syntax-highlighting
echo source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >> ~/.zshrc

# Tap into additional Homebrew channels
brew tap homebrew/cask-fonts
brew tap caskroom/cask

# Install Homebrew apps
brew install git
brew install mas
brew install neovim
brew install tmux

# Install App Store apps
mas install 497799835 # XCode
mas install 425424353 # The Unarchiver
mas install 1295203466 # Microsoft Remote Desktop 10
mas install 1262957439 # Textual 7
mas install 803453959 # Slack

# Install Casks
brew cask install homebrew/cask-drivers/logitech-options
brew cask install google-chrome
brew cask install firefox
brew cask install sabnzbd
brew cask install steam
brew cask install dropbox
brew cask install skype
brew cask install gitter
brew cask install spotify
brew cask install vnc-viewer
brew cask install github
brew cask install forklift
brew cask install iterm2
brew cask install java
brew cask install charles
brew cask install postman
brew cask install mysqlworkbench
brew cask install azure-data-studio
brew cask install mono-mdk
brew cask install dotnet-sdk
brew cask install visual-studio-code
brew cask install visual-studio
brew cask install rider
brew cask install vagrant
brew cask install vagrant-manager
brew cask install vmware-fusion
brew cask install vagrant-vmware-utility
brew cask install parallels
brew cask install parallels-toolbox
brew cask install adobe-creative-cloud
brew cask install paragon-ntfs
brew cask install docker
brew cask install kitematic

# Install Vagrant plugins
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-parallels
vagrant plugin install vagrant-vmware-desktop

# Fix Vagrant VMware Utility permissions
sudo find /opt/vagrant-vmware-desktop -type d -exec chmod 755 {} \;
sudo find /opt/vagrant-vmware-desktop -type f -exec chmod 644 {} \;
sudo chmod -R 755 /opt/vagrant-vmware-desktop/bin

# Install Visual Studio Code extensions
code --install-extension ms-vscode.csharp
code --install-extension editorconfig.editorconfig
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension shinnn.stylelint

# Install Node Version Manager, Node.js and Yarn
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
brew install yarn --without-node

# Install Ruby Version Manager
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
rvm use --latest

# Install spacemacs
brew tap d12frosted/emacs-plus
brew install emacs-plus
ln -s /usr/local/Cellar/emacs-plus/*/Emacs.app/ /Applications/
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
brew cask install font-source-code-pro

# Install VirtualBox and inform about manual steps
brew cask install virtualbox
echo -e "\e[1;32mMake sure to allow the VirtualBox extension before proceeding!\e[0m"
echo -e "\e[1;32mThen manually run the following commands:\e[0m"
echo brew cask install virtualbox
echo brew cask install virtualbox-extension-pack

# Open folders with additional manual installers
open /usr/local/Caskroom/parallels-toolbox
open /usr/local/Caskroom/adobe-creative-cloud
open /usr/local/Caskroom/paragon-ntfs
