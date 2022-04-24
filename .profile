# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

if [ -f /etc/openwrt_version ]; then
  # OpenWrt:
  export PS1='\[\033[35;1m\]'$PS1'\[\033[0m\]';
else
  # Debian:
  export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

force_color_prompt=yes
export LESS=-I

lf () { grep -i $1 /var/log/syslog | tail -n $(echo $2 50 | awk '{print $1}'   ); }
cf () { cat /proc/net/nf_conntrack | grep -i $1; }
#lf () { logread | sed "/cound not find a ser/d" | grep -i $1 | tail -n 50

#tur: tbc:
l () { grep -i $1 /var/log/messages | tail -n $(echo $2 50 | awk '{print $1}' ); }
lf () { sed "/cound not find a ser/d" /var/log/messages | grep -i "$1" | tail -n $(echo $2 50 | awk '{print    $1}' ); }

if [ $(readlink $(which ps) | grep busybox) ]; then
  p () { ps      | grep -i [${1:0:1}]${1:1}; }
else
  p () { ps -aux | grep -i [${1:0:1}]${1:1}; }
fi

alias la="ls -lap --group-directories-first --color=yes ";
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
