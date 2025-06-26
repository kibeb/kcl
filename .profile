# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
  if command -v mesg &> /dev/null
  then
    mesg n 2> /dev/null || true
  fi
fi

if [ -f /etc/openwrt_version ]; then
  # OpenWrt:
  export PS1='\[\033[35;1m\]'$PS1'\[\033[0m\]';
else
  # Debian: screen session or not:
  if [[ ${STY#*.} ]]; then
    export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\](${STY#*.}):\[\033[01;34m\]\w\[\033[00m\]\$ '
    export HISTFILE=~/.bash_history.${STY#*.}
  else
    export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  fi
fi

force_color_prompt=yes
export LESS=-IR

lf () { grep -i $1 /var/log/syslog | tail -n ${2:-50} ; }
lfl () { lf $1 ${2:-200} | less +G ; }
mf () { grep -i $1 /var/log/messages | tail -n ${2:-50} ; }
mfl () { mf $1 ${2:-200} | less +G ; }
cf () { cat /proc/net/nf_conntrack | grep -i $1 ; }
transfer () { curl -F "file=@$1" https://temp.sh/upload ; echo ; }
alfu () { if [ $# -eq 0 ]; then alias && declare -f | sed "/^[^a-zA-Z]/d;/^gaw/d"; else alias $1 2>/dev/null || declare -f $1 ;fi; }
unalias urldecode 2> /dev/null
urldecode () { echo $1 | (IFS="+"; read _z; echo -e ${_z//%/\\x}""); }
mv.urldec () { if [ $# -ne 2 ]; then return; fi; mv "$1" "$(urldecode $2)" ; }
#tur:
#mf () { sed "/cound not find a ser/d" /var/log/messages | grep -i "$1" | tail -n ${2:-50} ; }

if [ $(readlink $(which ps) | grep busybox) ]; then
  p () { ps      | grep -i [${1:0:1}]${1:1}; }
else
  p () { ps -aux | grep -i [${1:0:1}]${1:1}; }
fi

scr () {
  if [ "$#" == "0" ]; then screen -ls; return ; fi
  screen -ls | grep "\.$1\s.*(Detached)" && screen -r "$1" && return
  screen -ls | grep "\.$1\s" && echo "screen $1 is already attached somewhere, aborting." && return
  screen -S "$1" && return
}

tm () {
  if [ "$#" == "0" ]; then tmux ls; return ; fi
  tmux ls | grep -P "^$1:.*(attached)" && echo "tmux $1 is already attached somewhere, aborting." && return
  tmux ls | grep -P "^$1:" && tmux attach -t "$1" && return
  tmux new -s "$1" && return
}

alias la="ls -lap --group-directories-first --color=yes ";
alias lad="ls -lap --group-directories-first --color=yes | sed '/^d/!d' ";
alias ll="ls -lp --group-directories-first --color=yes ";
alias ping="ping -c 4 ";
alias cnt="find . -type f | wc -l ";
alias title='settitle(){ echo -ne "\\033]0;"$@"\\007"; unset -f settitle; }; settitle'
if [ -e /run/systemd/system ]; then
  alias sc="systemctl ";
  _completion_loader systemctl
  complete -F _systemctl sc
else
  alias sc='sc(){ /etc/init.d/$2 $1; unset -f sc; }; sc';
fi
alias apt.kinstall='apt install man-db vim netcat-openbsd net-tools bind9-dnsutils wget curl git screen btop';
alias apk.kinstall='apk add mandoc man-pages vim curl git screen';
alias lsblk.my='lsblk --help | grep "MOUNTPOINTS" && lsblk -o name,rm,size,ro,type,fstype,mountpoints,label,uuid || lsblk -o name,rm,size,ro,type,fstype,mountpoint,label,uuid';

if [ -f ~/.profile.lcl ]; then
  . ~/.profile.lcl
fi

