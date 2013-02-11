PROMPT='$fg[cyan]%m: %{$reset_color%} %{$fg[yellow]%}%c %{$fg[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$fg_bold[red]%}
➜ %{$reset_color%}'


function get_pwd() {
   echo "${PWD/$HOME/~}"
}

function git_prompt_info() {
   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
   echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]+"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"
