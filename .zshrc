plugins=(git)

# oh my posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/themes/neg.json)"
fi

set -o vi

PATH=~/.console-ninja/.bin:$PATH
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(zoxide init zsh)"
export GHOSTTY_CONFIG_FILE="$HOME/.config/ghostty/config"
export YAZI_CONFIG_HOME="$HOME/.config/yazi"

# Cargo
export CARGO_PATH="$HOME/.cargo/bin:$PATH"
export CARGO_CONFIG_FILE="$HOME/.config/rmpc/config.ron"
# -------------------------------------------------------------------------------------------------------

# fzf
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git --exclude node_modules'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_file() {
  fd --type=d --hidden --exclude .git . "$1"
}
source "$HOME/.config/scripts/fzf-git.sh/fzf-git.sh"
# -------------------------------------------------------------------------------------------------------

# most 
export PAGER="most"

alias ls="eza --long --color=always --icons=always --no-user"
alias l="ls -liah"
alias nzo="$HOME/.config/scripts/zoxide_openfiles_nvim.sh"
alias cd="z"
alias finder="yazi"
alias cat="bat"
