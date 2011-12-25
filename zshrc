# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew git osx github ruby rails3 rvm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# . ~/.zsh/config
# . ~/.zsh/aliases
# . ~/.zsh/completion

# use .localrc for settings specific to one system
# [[ -f ~/.localrc ]] && . ~/.localrc

# Automagical Bundle Exec
# From https://gist.github.com/1316656

BUNDLED_COMMANDS=(rails rake rspec ruby sass sass-convert spec spork)
# BUNDLED_COMMANDS=()

is-bundler-installed()
{
  which bundle > /dev/null 2>&1
}

is-within-bundled-project()
{
  local dir="$(pwd)"
  while [ "$(dirname $dir)" != "/" ]; do
    [ -f "$dir/Gemfile" ] && return
    dir="$(dirname $dir)"
  done
  false
}

run-with-bundler()
{
  if is-bundler-installed && is-within-bundled-project; then
    print "$fg[yellow]Using bundle exec...$reset_color"
    bundle exec $@
  else
    $@
  fi
}

for CMD in $BUNDLED_COMMANDS; do
  alias $CMD="run-with-bundler $CMD"
done



# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
