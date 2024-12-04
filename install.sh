#!/bin/bash

# Install Rosetta 2
softwareupdate --install-rosetta

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' | tee -a ~/.profile ~/.zprofile > /dev/null
source ~/.zprofile # Reload zsh config
brew analytics off

# Install OpenJDK
brew install openjdk
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Install rbenv and Ruby
brew install rbenv ruby-build
brew install libyaml # Build dependencies
echo 'eval "$(rbenv init -)"' | tee -a ~/.profile ~/.zprofile > /dev/null
source ~/.zprofile # Reload zsh config
RUBY_VERSION="3.2.2"
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION

# Install pyenv and Python
brew install pyenv
brew install openssl readline sqlite3 xz zlib tcl-tk # Build dependencies
echo 'export PYENV_ROOT="$HOME/.pyenv"' | tee -a ~/.profile ~/.zprofile > /dev/null
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' | tee -a ~/.profile ~/.zprofile > /dev/null
echo 'eval "$(pyenv init -)"' | tee -a ~/.profile ~/.zprofile > /dev/null
source ~/.zprofile # Reload zsh config
PYTHON_VERSION="3.11.5"
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

# Install zsh-nvm, nvm, Node.js LTS
git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm
echo source ~/.zsh-nvm/zsh-nvm.plugin.zsh >> ~/.zprofile
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.profile
source ~/.zprofile # Reload zsh config
nvm install --lts

# Install PHP, Composer and Laravel
brew install phpbrew
brew install autoconf pkg-config bzip2 # Build dependencies
phpbrew init
echo '[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc' | tee -a ~/.profile ~/.zprofile > /dev/null
source ~/.zprofile # Reload zsh config
PHP_VERSION="8.1.23"
phpbrew install $PHP_VERSION
phpbrew switch php-$PHP_VERSION
brew install composer
echo 'export PATH=$PATH:$HOME/.composer/vendor/bin' >> ~/.zprofile
source ~/.zprofile # Reload zsh config
echo export COMPOSER_MEMORY_LIMIT=-1 >> ~/.zshrc
echo "alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'" >> ~/.zshrc # Create Laravel Sail alias
source ~/.zshrc # Reload zsh config

# Install Starship
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
brew install starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
source ~/.zshrc # Reload zsh config

# Install Zsh plugins
brew install zsh-autosuggestions
echo source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh >> ~/.zshrc
brew install zsh-syntax-highlighting
echo source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh >> ~/.zshrc
source ~/.zshrc # Reload zsh config

# Install App Store apps
brew install mas
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
brew install hashicorp/tap/packer
brew install eza
brew install kubecolor

# Alias system tools
echo 'alias ls="eza"' >> ~/.zshrc
echo 'alias kubectl="kubecolor"' >> ~/.zshrc

# Install Neovim and set as default editor
brew install neovim
echo 'export EDITOR="nvim"' >> ~/.zshrc

# Install .NET and NUKE
brew install --cask dotnet-sdk # Newest .NET SDK
echo 'export PATH=$PATH:$HOME/.dotnet/tools' >> ~/.zprofile
source ~/.zprofile # Reload zsh config
dotnet tool install Nuke.GlobalTool --global

# Additional .NET SDK versions
brew tap isen-ng/dotnet-sdk-versions
brew install --cask dotnet-sdk6-0-400

# Install Casks
brew install --cask azure-data-studio
brew install --cask balenaetcher
brew install --cask bluesnooze
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

# Install Composer packages
composer global require laravel/installer

# Install Ruby gems
gem install bundler
gem install jekyll
gem install ultrahook

# Install drivers
brew tap homebrew/cask-drivers
brew install logi-options-plus
brew install --cask paragon-extfs
brew install --cask paragon-ntfs

# Install Casks requiring extra intervention
brew install --cask teamviewer

# Open folders containing manual installers
open /opt/homebrew/Caskroom/logi-options-plus
open /opt/homebrew/Caskroom/paragon-extfs
open /opt/homebrew/Caskroom/paragon-ntfs
