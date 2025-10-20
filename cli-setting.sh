# Install homebrew
echo "📦 Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Cask
echo "📦 Installing Fomulars and Casks Using homebrew"
brew 
brew install git gnupg bat fzf fd fnm eza go fastfetch openjdk@21 portal ripgrep thefuck tree zoxide zsh-autosuggestions zsh-syntax-highlighting starship oven-sh/bun/bun rbenv neovim git-delta gemini-cli hashicorp/tap/terraform
brew install --cask font-fira-code-nerd-font orbstack google-chrome zen raycast slack notion ghostty beekeeper-studio cursor karabiner-elements visual-studio-code bruno chatgpt

# Set hushlogin
echo "📦 Setting hushlogin for terminal environment"
touch ~/.hushlogin

# Set Fnm and yarn before .zsh setting
echo "📦 Install NodeJS LTS and Yarn"
eval "$(fnm env --use-on-cd)"
fnm install lts/latest
npm install --global yarn pnpm

# ruby
echo "📦 Install Ruby"
eval "$(rbenv init - --no-rehash zsh)"
rbenv install 3.4.6
rbenv global 3.4.6
gem install bundler

# Set .zshrc
echo "📦 Setting .zshrc"
touch ~/.zshrc

ZSH_CONTENT=$(cat << 'EOF'
# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# fnm
eval "$(fnm env --use-on-cd)"

# Yarn
export PATH="$PATH:$(yarn global bin)"

# Pnpm
alias pn=pnpm

# open JDK
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# Go install path
export PATH="$HOME/go/bin:$PATH"

# Flutter install path
export PATH=$HOME/flutter/bin:$PATH

# Ruby gem
export PATH=$HOME/.gem/bin:$PATH

# the Fuck
eval $(thefuck --alias fuck)

# custom alias
alias ls="eza --color=always --long --no-filesize --icons=always"
alias ld="eza -lD"
alias lf="eza -lf --color=always | grep -v /"
alias lh="eza -dl .* --group-directories-first"
alias ll="eza -al --group-directories-first"
alias ls="eza -alf --color=always --sort=size | grep -v /"
alias lt="eza -al --sort=modified"
alias l="ll"

eval "$(zoxide init zsh)"
alias cd="z"

alias diff="delta"

# OrbStack command-line tools
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# zsh plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# FZF
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"

fastfetch
EOF
)

echo "$ZSH_CONTENT" >> ~/.zshrc
source ~/.zshrc
echo "📦 Setting .zshrc Complete"

# ApplePressAndHoldEnabled for VSCode, Cursor
echo "📦 Setting VIM mode for vscode and cursor"
defaults write "$(osascript -e 'id of app "Cursor"')" ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false 

# AWS-CLI
echo "📦 Setting AWS CLI"
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

echo "📦 For Develop flutter, visit https://docs.flutter.dev/get-started/install/macos/mobile-ios"
echo "✅ All cli setting is done. Let's hack!"
