# fnm
eval "$(fnm env --use-on-cd)"

# Yarn
export PATH="$PATH:$(yarn global bin)"

# Pnpm
alias pn=pnpm

# Go install path
export PATH="$HOME/go/bin:$PATH"

# Direnv
eval "$(direnv hook zsh)"


# =================custom alias====================
alias cat="bat"

alias ls="eza -al --icons=always --group-directories-first --color=always"
alias ld="eza -lD --icons=always --color=always"
alias lf="eza -lf --color=always --icons=always | grep -v /"
alias lh="eza -dl .* --icons=always --group-directories-first --color=always"
alias lS="eza -al --icons=always --sort=size --group-directories-first --color=always"
alias lt="eza -al --icons=always --sort=modified --group-directories-first --color=always"
alias ll="eza -al --icons=always --group-directories-first --color=always"
alias l="ll"

alias diff="delta"

eval "$(zoxide init zsh)"
alias cd="z"

# ===================fzf setting=======================
# git branch selection with fzf → checkout
fbr() {
  local branch
  branch=$(git branch --all | sed 's/^[* ]*//' | fzf --prompt="  " --height=40% --border) || return
  git checkout "$(echo "$branch" | sed 's#remotes/[^/]*/##')"
}

# git branch selection with fzf → detail preview
fshow() {
  git log --oneline --decorate |
    fzf --preview 'git show --color=always $(echo {} | cut -d" " -f1)' \
        --preview-window=down:60%:wrap
}

alias gitbranch=fbr
alias gitlog=fshow

# fzf + ripgrep + bat + nvim Integration Search
frg() {
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")
  rg --line-number --no-heading --color=always "" "$root" |
    fzf --ansi \
        --delimiter : \
        --preview 'bat --color=always --style=numbers --highlight-line {2} {1}' \
        --bind 'enter:execute(nvim +{2} {1}),ctrl-j:preview-down,ctrl-k:preview-up' \
        --preview-window=down:60%:wrap
}
# Ctrl+G = execute frg (zle wiget)
function frg-widget() {
  zle -I                # clear
  frg                   # execute function
  zle redisplay         # start draw prompt 
}
zle -N frg-widget
bindkey '^G' frg-widget

# Ctrl+P = find file with file name
ffile() {
  find . -type f \( ! -path '*/.git/*' \) |
    fzf --ansi \
        --preview 'bat --color=always --style=header,grid --line-range=:200 {}' \
        --bind "enter:execute(nvim '{}'),ctrl-j:preview-down,ctrl-k:preview-up" \
        --preview-window=down:60%:wrap
}

function ffile-widget() {
  zle -I
  ffile
  zle redisplay
}
zle -N ffile-widget
bindkey '^P' ffile-widget
# =========================================================


# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# FZF
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"

fastfetch
