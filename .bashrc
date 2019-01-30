# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
PATH=/home/chrome/depot_tools:$PATH
umask 022
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias j='jobs'
alias grep='grep --color'
alias gvim='LESS_TERMCAP_mb='' LESS_TERMCAP_md='' LESS_TERMCAP_me='' LESS_TERMCAP_se='' LESS_TERMCAP_so='' LESS_TERMCAP_ue='' LESS_TERMCAP_us='' gvim'
alias apti='sudo apt-get install'
alias apts='apt-cache search'
alias lt="ls -R|grep :|sed -e 's/:$//;s/[^-][^\/]*\//--/g;s/^/ /;s/-/|/'"
alias gitc='git checkout'
alias gitb='git branch'
alias gits='git status'
alias gitcp='git cherry-pick'
alias gitr='git reset --hard HEAD'
alias gitrr='git reset --hard HEAD^'
alias ff='find . -name'

alias rlbashrc='source ~/.bashrc'
alias setenv='source build/envsetup.sh && lunch'
alias clog='adb logcat -c'
alias gtk='sudo gtkterm &'
alias src='cd /media/src'

function adbc {
    adb kill-server
    adb connect $1
}

function push {
    adb remount
    adb push $1 $2
}

function umdd {
    sudo -S umount /dev/$2*
    sudo dd if=out/target/product/$1/live.img of=/dev/$2 bs=1M;sync
}

function slog {
    adb logcat -v time > $1.log
}

function sdmesg {
    adb shell dmesg > $1.log
}

export USE_CCACHE=1

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function grepj()
{
    find . -type f \( -name "*\.java" -o -name '*.txt' \) -print0 | xargs -0 grep --color -n "$@"
}

function grepc()
{
    find . -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' \) -print0 | xargs -0 grep --color -n -i "$@"
}

function grepmk()
{
    find . -type f \( -iname '*.mk' -o -iname 'Makefile' \) -print0 | xargs -0 grep --color -n -i "$@"
}

function grepxml()
{
    for dir in `find . -name res -type d`; do find $dir -type f -name '*\.xml' -print0 | xargs -0 grep --color -n -i "$@"; done;
}

function grepx()
{
    find . -type f -name "*.xml" -print0 | xargs -0 grep --color -n -i "$@"
}

function grepsh()
{
    find . -type f -name "*.sh" -print0 | xargs -0 grep --color -n -i "$@"
}

function grepk()
{
    find . -type f -name "Kconfig*" -print0 | xargs -0 grep --color -n -i "$@"
}

function grepdef()
{
    find . -type f -name "*config" -print0 | xargs -0 grep --color -n -i "$@"
}

function grepp()
{
    find . -type f -name "$1" -print0 | xargs -0 grep --color -n -i "$2"
}

function greprc()
{
    find . -type f -name "*.rc" -print0 | xargs -0 grep --color -n -i "$@"
}

function grepidl()
{
    find . -type f -name "*idl" -print0 | xargs -0 grep --color -n -i "$@"
}

function grepasl()
{
    find . -type f -name "*.asl" -print0 | xargs -0 grep --color -n "$@"
}
