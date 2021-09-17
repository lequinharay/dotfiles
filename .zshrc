export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true
export GREP_OPTIONS='--color=auto'

# for pyenv
eval "$(pyenv init -)"

# for Homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# for chef knife
export PATH=/usr/local/Cellar/ruby/2.0.0-p353/lib/ruby/gems/2.0.0/gems/chef-11.12.4/bin:$PATH
# for berks
export PATH=/usr/local/Cellar/ruby/2.0.0-p353/lib/ruby/gems/2.0.0/gems/berkshelf-3.1.2/bin:$PATH
# User bin
export PATH=$HOME/bin:$PATH
# for composer
export PATH=$PATH:$HOME/bin:$HOME/.composer/vendor/bin:$HOME/vendor/bin

export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future
HELPDIR=/usr/local/share/zsh/helpfiles

setopt no_beep           # ビープ音
setopt auto_cd           # ディレクトリ名の入力のみで移動
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告
setopt equals            # =commandを`which command`と同じ処理
setopt combining_chars   # 濁点・半濁点の表示を正常にする

bindkey -e               # キーバインドをemacsモードに設定

### Complement ###
autoload -U compinit; compinit # 補完機能を有効
setopt auto_list               # 補完候補を一覧で表示(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示
setopt list_types              # 補完候補にファイルの種類も表示
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

setopt extended_glob
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE="$HOME/.zsh_history"   # ヒストリを保存するファイル
HISTSIZE=100000            # メモリに保存されるヒストリの件数
SAVEHIST=100000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_ignore_space
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# すべてのヒストリを表示
function history-all { history -E 1 }

# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''


# 文字区切りの設定
autoload -Uz select-word-style
select-word-style defaultzstyle
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified

# プロンプトに色
autoload -U colors; colors
PROMPT="[%n]:%{${fg[yellow]}%}%~%{${reset_color}%}$ "
PROMPT2='[%n]> '

# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

### Title (user@hostname) ###
case "${TERM}" in
kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac

### Aliases ###
alias vi=vim
alias gf="git-flow"
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GF"
  ;;
linux*)
  alias ls="ls -F --color"
  ;;
esac

alias ll='ls -lG'
alias la='ls -aG'
alias lla='ls -laG'

case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST}\007"
    }
    ;;
esac

function alc() {
  if [ $# != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
  else
    w3m "http://www.alc.co.jp/"
  fi
}

function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -m SimpleHTTPServer "$port"
}

# for Stagehead
alias testc="testrunner cakephp -p ~/.composer/vendor/autoload.php --cakephp-app-path='app'"
