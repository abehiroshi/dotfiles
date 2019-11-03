# -------------------------------------------------------------
# zsh設定

# -------------------------------------------------------------
# zplug

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug load

# zsh-completions
fpath=(~/.zplug/repos/zsh-users/zsh-completions/src ~/.zsh/completion $fpath)


# -------------------------------------------------------------
# プロンプト

bindkey -v

# git設定
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# 左プロンプト
PROMPT='${vcs_info_msg_0_}%B$%b '
# 右プロンプト
RPROMPT=$'%{\e[32m%}[%~]%{\e[m%}'

# -------------------------------------------------------------
# 補完

# 小文字でも大文字の候補を出す
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# aliasも候補に出す
setopt complete_aliases
# 候補を詰めて表示
setopt list_packed
# 警告を非表示
setopt nonomatch

# コマンドを予測
autoload -Uz predict-on; predict-on
# Ctrl-x pで予測ON　Ctrl-x Ctrl-pで予測OFF
zle -N predict-on
zle -N predict-off
bindkey '^xp' predict-on
bindkey '^x^p' predict-off
# 予測ON,OFFを表示
zstyle ':predict' verbose true
# コマンド編集時は予測OFF
zstyle ':predict' toggle true

# コマンドのオプション、引数を補完
autoload -Uz compinit; compinit -i

# -------------------------------------------------------------
# 色
autoload -Uz colors; colors

export LS_COLORS='no=00:fi=00:di=01;32:ln=36:ex=32'

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# -------------------------------------------------------------
# 履歴

# コマンド履歴を共有
setopt share_history
# コマンド履歴から重複を除去
setopt hist_ignore_dups
# コマンド履歴ファイル
HISTFILE=~/.zsh_history
# コマンド履歴サイズ
HISTSIZE=10000
SAVEHIST=10000

# cdの履歴を保存
setopt auto_pushd
# cdの履歴から重複を削除
setopt pushd_ignore_dups


# -------------------------------------------------------------
# path

case ${OSTYPE} in
  darwin*)
    path=(
      /usr/local/opt/binutils/bin(N-/) # binutils
      /usr/local/opt/coreutils/libexec/gnubin(N-/) # coreutils
      /usr/local/opt/ed/libexec/gnubin(N-/) # ed
      /usr/local/opt/findutils/libexec/gnubin(N-/) # findutils
      /usr/local/opt/gnu-sed/libexec/gnubin(N-/) # sed
      /usr/local/opt/gnu-tar/libexec/gnubin(N-/) # tar
      /usr/local/opt/grep/libexec/gnubin(N-/) # grep
      ${path}
    )
    manpath=(
      /usr/local/opt/coreutils/libexec/gnuman(N-/) # coreutils
      /usr/local/opt/ed/libexec/gnuman(N-/) # ed
      /usr/local/opt/findutils/libexec/gnuman(N-/) # findutils
      /usr/local/opt/gnu-sed/libexec/gnuman(N-/) # sed
      /usr/local/opt/gnu-tar/libexec/gnuman(N-/) # tar
      /usr/local/opt/grep/libexec/gnuman(N-/) # grep
      ${manpath}
    )
    ;;
esac

# -------------------------------------------------------------
# alias

# for interactive operation
  alias rm='rm -i'
  alias cp='cp -i'
  alias mv='mv -i'

# alias for misc
  alias grep='grep --color'

# alias for some shortcuts for different directory listings
  alias ls='ls -h --color=always'
  alias ll='ls -l'
  alias la='ls -A'
  alias l='ls -CF'

# -------------------------------------------------------------

# 外部定義ファイル
ls -1 --color=never ${ZDOTDIR}/.zshrc.* 2> /dev/null | while read -r file
do
  source $file
done
