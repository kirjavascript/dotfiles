# zplug install;
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "supercrabtree/k"

zplug "plugins/git", from:oh-my-zsh
zplug "themes/fishy", from:oh-my-zsh

# zplug "sebastiencs/icons-in-terminal", hook-build: "./install.sh", use: "~/.local/share/icons-in-terminal/icons_bash.sh"
zplug "jaseg/lolcat", hook-build: "make && make install"

zplug load

# environment
export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox
export WORDCHARS=''
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

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
alias k='k -h'
alias lolcat='~/.zplug/repos/jaseg/lolcat/lolcat-static | head -c -5'
alias lk='ls | lolcat'
alias ls='ls -hF --show-control-chars --color=always'
alias la='ls -haF --show-control-chars --color=always'
alias ll='ls -lhF --show-control-chars --color=always'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# prompt
# example; print -P '%B%K{blue}%F{white}test%f%b%k'

# theme overrides
declare -a colors
colors=('green' 'blue' 'magenta' 'red')
prompt_color=$colors[$((${RANDOM} % ${#colors[@]} + 1))]

PROMPT='%B%F{$prompt_color}$(_fishy_collapsed_wd)%f%b$(git_prompt_info)$(git_prompt_status)%F{$prompt_color}%B➤%f%b '
RPROMPT=''

ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}✔%f"
