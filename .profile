# ~/.profile

if [ -f /etc/openwrt_version ]; then
  # OpenWrt:
  export PS1='\[\033[35;1m\]'$PS1'\[\033[0m\]';
else
  # Debian:
  export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

force_color_prompt=yes

alias la="ls -lap --group-directories-first --color=yes ";
alias ll="ls -lp --group-directories-first --color=yes ";
alias ping="ping -c 4 ";
alias cnt="find . -type f | wc -l ";
alias title='settitle(){ echo -ne "\\033]0;"$@"\\007"; unset -f settitle; }; settitle'
if [ -e /run/systemd/system ]; then
  alias sc="systemctl ";
else
  alias sc='sc(){ /etc/init.d/$2 $1; unset -f sc; }; sc';
fi
