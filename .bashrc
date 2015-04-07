# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
export EDITOR=vim
export GREP_OPTIONS='--color=auto'

# User specific aliases and functions
function svnstatus(){ svn status -u | grep -v jpg$ | grep -v templates_c/ ; }

alias ll='ls -l'
alias la='ls -a'

alias yf='open -a Yorufukurou'
alias ch='open -a Google\ Chrome'
alias ff='open -a Firefox'

function server() {
        local port="${1:-8000}"
        open "http://localhost:${port}/"
        python -m SimpleHTTPServer "$port"
}
# for Homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# for chef knife
export PATH=/usr/local/Cellar/ruby/2.0.0-p247/lib/ruby/gems/2.0.0/gems/chef-11.8.0/bin:$PATH
# for berks
export PATH=/usr/local/Cellar/ruby/2.0.0-p247/lib/ruby/gems/2.0.0/gems/berkshelf-2.0.10/bin:$PATH

export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future
