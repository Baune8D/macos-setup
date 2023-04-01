#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"

# Install OpenJDK
brew install openjdk
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Install rbenv and Ruby
brew install rbenv ruby-build
brew install libyaml # Build dependencies
echo 'eval "$(rbenv init -)"' | tee -a ~/.profile ~/.zprofile > /dev/null
source ~/.zshrc # Reload zsh config
LATEST_RUBY_VERSION="$(rbenv install -l | grep -v - | tail -1 | tr -d '[[:space:]]')"
rbenv install $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION

# Install pyenv and Python
brew install pyenv
brew install openssl readline sqlite3 xz zlib tcl-tk # Build dependencies
echo 'export PYENV_ROOT="$HOME/.pyenv"' | tee -a ~/.profile ~/.zprofile > /dev/null
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' | tee -a ~/.profile ~/.zprofile > /dev/null
echo 'eval "$(pyenv init -)"' | tee -a ~/.profile ~/.zprofile > /dev/null
source ~/.zshrc # Reload zsh config
LATEST_PYTHON_VERSION="$(pyenv install -l | grep -v -e - -e a | grep '\.' | tail -1 | tr -d '[[:space:]]')"
pyenv install $LATEST_PYTHON_VERSION
pyenv global $LATEST_PYTHON_VERSION

# Install zsh-nvm, nvm, Node.js LTS
git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm
echo source ~/.zsh-nvm/zsh-nvm.plugin.zsh >> ~/.zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
source ~/.zshrc # Reload zsh config
nvm install --lts

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Zsh plugins
brew install zsh-autosuggestions
echo source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh >> ~/.zshrc
brew install zsh-syntax-highlighting
echo source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >> ~/.zshrc
source ~/.zshrc # Reload zsh config

# Install App Store apps
brew install mas
mas install 425424353 # The Unarchiver
mas install 803453959 # Slack
mas install 1063631769 # Medis
mas install 1147396723 # WhatsApp
mas install 1262957439 # Textual IRC Client
mas install 1295203466 # Microsoft Remote Desktop
mas install 1451685025 # WireGuard
mas install 1480068668 # Messenger

# Install Homebrew packages
brew install git
brew install nuget
brew install tmux
brew install zsh

# Install Neovim and set as default editor
brew install neovim
echo 'export EDITOR="nvim"' >> ~/.zshrc

# Install PHP, Composer and Laravel
brew install php
brew install composer
echo export COMPOSER_MEMORY_LIMIT=-1 >> ~/.zshrc
echo 'export PATH=$PATH:$HOME/.composer/vendor/bin' >> ~/.zprofile
source ~/.zshrc # Reload zsh config
composer global require laravel/installer
echo "alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'" >> ~/.zshrc # Create Laravel Sail alias
source ~/.zshrc # Reload zsh config

# Install .NET and NUKE
brew install --cask dotnet-sdk # Newest .NET SDK
echo 'export PATH=$PATH:$HOME/.dotnet/tools' >> ~/.zprofile
source ~/.zshrc # Reload zsh config
dotnet tool install Nuke.GlobalTool --global

# Additional .NET SDK versions
brew tap isen-ng/dotnet-sdk-versions
brew install --cask dotnet-sdk6-0-400

# Install Casks
brew install --cask azure-data-studio
brew install --cask balenaetcher
brew install --cask charles
brew install --cask discord
brew install --cask docker
brew install --cask firefox
brew install --cask forklift
brew install --cask github
brew install --cask google-drive
brew install --cask google-chrome
brew install --cask google-cloud-sdk
brew install --cask imageoptim
brew install --cask iterm2
brew install --cask jetbrains-toolbox
brew install --cask libreoffice
brew install --cask mamp
brew install --cask mono-mdk
brew install --cask mysqlworkbench
brew install --cask ngrok
brew install --cask parallels
brew install --cask parallels-virtualization-sdk
brew install --cask plex
brew install --cask postman
brew install --cask powershell
brew install --cask pronterface
brew install --cask raspberry-pi-imager
brew install --cask sabnzbd
brew install --cask sdformatter
brew install --cask spotify
brew install --cask steam
brew install --cask vagrant
brew install --cask vagrant-vmware-utility
brew install --cask virtualbox
brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask vmware-fusion
brew install --cask vnc-viewer
brew install --cask warp
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

# Install drivers
brew tap homebrew/cask-drivers
brew install --cask caldigit-thunderbolt-charging
brew install --cask logi-options-plus
brew install --cask paragon-extfs
brew install --cask paragon-ntfs

# Install Casks requiring extra intervention
brew install --cask teamviewer

# Open folders containing manual installers
open /usr/local/Caskroom/logi-options-plus
open /usr/local/Caskroom/paragon-extfs
open /usr/local/Caskroom/paragon-ntfs
