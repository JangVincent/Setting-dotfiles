# Install homebrew
echo "📦 Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Cask
echo "📦 Installing Fomulars and Casks Using homebrew"
brew install bat fzf fnm eza go fastfetch openjdk@21 portal ripgrep thefuck tree zoxide zsh-autosuggestions zsh-syntax-highlighting starship oven-sh/bun/bun neovim git-delta
brew install --cask font-fira-code-nerd-font orbstack google-chrome raycast slack notion ghostty beekeeper-studio visual-studio-code karabiner-elements keycastr bruno

# Set hushlogin
touch ~/.hushlogin

# Set Fnm and yarn before .zsh setting
eval "$(fnm env --use-on-cd)"
fnm install 22.17.0
npm install --global yarn


# Set .zshrc
touch ~/.zshrc

ZSH_CONTENT=$(cat << 'EOF'
# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# fnm
eval "$(fnm env --use-on-cd)"

# Yarn
export PATH="$PATH:$(yarn global bin)"

# open JDK
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# Go install path
export PATH="$HOME/go/bin:$PATH"

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

alias cd="z"
eval "$(zoxide init zsh)"

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

# git log custom
git() {
  if [[ $1 == "log" ]]; then
    command git log --date=short --pretty=format:"%C(yellow)%h%Creset - %C(cyan)%an%Creset, %C(green)%ad%Creset : %C(magenta)%s%Creset %C(auto)%d%Creset"
  else
    command git "$@"
  fi
}

fastfetch
EOF
)

## .zshrc에 내용 추가
echo "$ZSH_CONTENT" >> ~/.zshrc
source ~/.zshrc

## 완료 메시지
echo "📦 Setting .zshrc Complete"
