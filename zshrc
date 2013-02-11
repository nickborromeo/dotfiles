# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
 alias zshconfig="vim ~/.zshrc"
 alias vimconfig="vim ~/.vimrc"
 alias psqlstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
# alias ohmyzsh="mate ~/.oh-my-zsh"
 alias greasemonkey="cd /Users/nickborromeo/Library/Application\ Support/Firefox/Profiles/r2afdg8r.default/gm_scripts"
 alias tmux="TERM=screen-256color-bce tmux"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin::/Users/nickborromeo/.rvm/bin:/Users/nickborromeo/JRuby/jruby-1.7.0.preview2/bin
export ORACLE_HOME=/opt/oracle/instantclient
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$ORACLE_HOME:$DYLD_LIBRARY_PATH
export TNS_ADMIN="/opt/oralce/instantclient/network/admin"
export CLASSPATH="/Users/nickborromeo/JRuby/Oracle-Driver/ojdbc6.jar"
