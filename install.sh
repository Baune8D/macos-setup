#!/bin/bash

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Setup shell (oh-my-zsh)
brew install zsh zsh-completions
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.zshrc
brew install zsh-autosuggestions
echo source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh >> ~/.zshrc
brew install zsh-syntax-highlighting
echo source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >> ~/.zshrc

# Tap into additional Homebrew channels
brew tap homebrew/cask-fonts

# Install XCode
brew install mas
mas install 497799835
sudo xcodebuild -license accept

# Install other App Store apps
mas install 425424353 # The Unarchiver
mas install 1295203466 # Microsoft Remote Desktop 10
mas install 1262957439 # Textual 7
mas install 803453959 # Slack

# Install Homebrew apps
brew install git
brew install neovim
brew install tmux
brew install dos2unix

# Install Casks (drivers)
brew cask install homebrew/cask-drivers/logitech-options
brew cask install paragon-ntfs

# Install Casks (virtualization)
brew cask install vagrant
brew cask install vagrant-manager
brew cask install vmware-fusion
brew cask install vagrant-vmware-utility
brew cask install parallels
brew cask install docker
brew cask install kitematic

# Install Casks (languages)
brew cask install powershell
brew cask install java
brew cask install mono-mdk
brew cask install dotnet-sdk

# Install Casks (development)
brew cask install ngrok
brew cask install github
brew cask install charles
brew cask install postman
brew cask install mysqlworkbench
brew cask install azure-data-studio
brew cask install visual-studio-code
brew cask install visual-studio
brew cask install rider

# Install Casks (other)
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
brew cask install parallels-toolbox
brew cask install adobe-creative-cloud
brew cask install imageoptim

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

# Install Node Version Manager, zsh-nvm, Node.js and Yarn
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm
echo source ~/.zsh-nvm/zsh-nvm.plugin.zsh >> ~/.zshrc
nvm install --lts
brew install yarn --ignore-dependencies

# Install rbenv and update Ruby
brew install rbenv
echo 'eval "$(rbenv init -)"' | tee -a ~/.bash_profile ~/.zshrc > /dev/null
rbenv init -
LATEST_RUBY_VERSION="$(rbenv install -l | grep -v - | tail -1 | tr -d '[[:space:]]')"
rbenv install $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION

# Install Ruby Gems
gem install ultrahook

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
