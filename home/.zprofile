# Loading sequence
#   zshenv > zprofile > zshrc > zlogin
# Each file is loaded when
#   zshenv   : login shell | interactive shell | shell script
#   zprofile : login shell |                   |
#   zshrc    : login shell | interactive shell |
#   zlogin   : login shell |                   |

# enable homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# zsh - color
autoload -Uz colors
colors

# zsh - completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# zsh - word delimiter
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# zsh - history
setopt extended_history
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt hist_no_store
setopt inc_append_history
setopt share_history
alias history='history -t "%FT%T%z"'
# bindkey "^R" history-incremental-search-backward
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^S" history-incremental-search-forward

# zsh - optional
setopt extended_glob
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt auto_pushd
setopt pushd_ignore_dups

# alias
alias ls='ls -G -F'
alias ipg="curl ipconfig.io"
alias ipg2="dig myip.opendns.com @208.67.222.222 +short"
alias ipl="ifconfig en0"
alias getif="networksetup -listallhardwareports"
alias originmac="networksetup -getmacaddress Wi-Fi | awk '{print \$3}'"
alias randommac="openssl rand -hex 6 | sed -E 's/(..)/\1:/g; s/./0/2; s/.$//'"
alias del_from_known_host="ssh-keygen -R"
alias dockerip="docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias dockerup="docker compose up -d --build"
alias brewtree="brew deps --tree --installed --formula"
alias brewdeps="brew list --formula | xargs -I{} sh -c 'brew uses --installed {} | wc -l | xargs printf \"%20s is used by %2d formulae.\n\" {}'"
alias gpgls='gpg --list-secret-keys --keyid-format=long'

# path
export PATH=$HOME/.bin:$PATH

# gnu sed, grep
export EDITOR=vi
export PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH

# less
export LESS="-iRMXS"

# direnv
eval "$(direnv hook zsh)"

# aws
fnc aws() {
  ARGS=()
  while [[ $# -gt 0 ]]; do
    case $1 in
      -p|--profile)
        PROFILE="$2"
        shift # past argument
        shift # past value
        ;;
      *)
        ARGS+=("$1") # save positional arg
        shift # past argument
        ;;
    esac
  done
  if [ -z "$PROFILE" ]; then
    echo 'Required argument not specified. Usage: aws --profile <command>' 1>&2
    return 1
  fi
  aws-vault exec $PROFILE -- docker run -it --rm --name aws -e AWS_REGION -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN --mount type=bind,source=$(pwd),target=/aws amazon/aws-cli ${ARGS[@]}
}

# ngrok
func ngrok() {
  arg="$1"
  authtoken="$2"
  if [ "$arg" != '--authtoken' ] || [ -z "$authtoken" ]; then
    echo 'Required argument not specified. Usage: ngrok --authtoken <token>' 1>&2
    return 1
  fi
  docker run --rm -it -v $HOME/.config/ngrok/ngrok.yml:/etc/ngrok.yml -e NGROK_CONFIG=/etc/ngrok.yml -e NGROK_AUTHTOKEN=${authtoken} ngrok/ngrok:latest
}

# load from alter files
ZSHHOME="$HOME/.zsh.d"
if [ -d $ZSHHOME ] && [ -r $ZSHHOME ] && [ -n "$(ls $ZSHHOME)" ]; then
  for i in $ZSHHOME/*; do
    if [[ ${i##*/} = *.zsh ]]; then
      # *.zsh is file or simlink, and it is readable
      ([ -f $i ] || [ -h $i ]) && [ -r $i ] && source $i
    fi
  done
fi

# inspect zsh loading
if (which zprof > /dev/null 2>&1) ;then
  # zprof
fi

