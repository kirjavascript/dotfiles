# zplug install;
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting"
zplug "softmoth/zsh-vim-mode"

zplug "plugins/git", from:oh-my-zsh
zplug "themes/fishy", from:oh-my-zsh

zplug load

# environment
export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox
export WORDCHARS=''
export ANDROID_HOME=$HOME/Android/Sdk
export NDK_HOME=$HOME/Android/Sdk/ndk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export DEVKITPPC=/opt/devkitpro/devkitPPC
export SUDO_PROMPT='[beep boop please login] '
export BSPWM_SOCKET='/tmp/bspwm-tmp'
export DENO_INSTALL="/home/cake/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
# keys
# use cat to get the secret codez
bindkey "^[[1;5C" forward-word # ctrl-left
bindkey "^[[1;5D" backward-word # ctrl-right
bindkey "^[[H" beginning-of-line # home
bindkey "^[[F" end-of-line # end
bindkey "^[[3~" delete-char # delete
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# aliases
alias gittree='git log --pretty=oneline --graph --decorate --all'
alias tmux='TERM=screen-256color-bce tmux'
alias ls='ls -hF --show-control-chars --color=always'
alias la='ls -haF --show-control-chars --color=always'
alias ll='ls -lhF --show-control-chars --color=always'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

csv() {
    column -s, -t < "$1" | less -#2 -N -S
}
color()(set -o pipefail;"$@" 2> >(sed $'s,.*,\e[31m&\e[m,'>&2))
notgd() {
    curl -s "https://i.not.gd/up" -H "Content-type: $(file -b --mime-type $1)" --data-binary "@$1" | jq -r '.href'
}
gch() {
    git checkout $(git for-each-ref refs/heads/ --format='%(refname:short)' | fzf)
}

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_IGNORE_DUPS

# prompt
# example; print -P '%B%K{blue}%F{white}test%f%b%k'

# theme overrides
declare -a colors
colors=('green' 'blue' 'magenta' 'red')
if [ "$HOST" = circular ]; then
    prompt_color='cyan'
else
    prompt_color=$colors[RANDOM%$#colors+1]
fi

PROMPT='%B%F{$prompt_color}$(_fishy_collapsed_wd)%f%b$(git_prompt_info)$(git_prompt_status)%F{$prompt_color}%B➤%f%b '
RPROMPT=''
#
# Show what mode ZLE is in
function zle-line-init zle-keymap-select {
    VIMPROMPT="%F{yellow} [NORMAL] %f"
    RPS1="${${KEYMAP/vicmd/$VIMPROMPT}/(main|viins)/}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}✔%f"

# pnpm
export PNPM_HOME="/home/cake/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Wasmer
export WASMER_DIR="/home/cake/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# bun completions
[ -s "/home/cake/.bun/_bun" ] && source "/home/cake/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
