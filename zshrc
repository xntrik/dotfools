source ~/.zshuery/zshuery.sh
load_defaults
load_aliases
load_lol_aliases
load_completion $yourdotfiles/zshuery/completion
load_correction
#source /usr/local/bin/aws_zsh_completer.sh

prompts '%{$fg_bold[yellow]%}$(COLLAPSED_DIR)%{$reset_color%}$(virtualenv_info) %{$fg[yellow]%}$(prompt_char)%{$reset_color%} ' '%{$fg[yellow]%}$(ruby_version)%{$reset_color%}'

export EDITOR='vim'
chpwd() {
    update_terminal_cwd
}
alias ls='ls -FG'
#alias gtfo='git fetch origin; git diff --name-status master..origin/master'
alias gtfo='git up; git diff --name-status master..origin/master'
alias gmom='git merge origin/master'
alias ll='ls -alh'
bindkey '^R' history-incremental-search-backward
#export PATH="$(brew --prefix)/bin:$PATH"
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word
if [ -f ~/.zshrc-alias ]; then
    source ~/.zshrc-alias
fi

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
