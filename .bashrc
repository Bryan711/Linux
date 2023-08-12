### EXPORT
#export TERM="xterm-256color"              # getting proper colors

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

### CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;      
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### ALIASES ###

#Weather
#alias weather="curl wttr.in/orlando"
alias weather="curl v2.wttr.in/orlando"

# useful tools
alias 2up='pdfjam --nup 2x1 --suffix 2up --landscape --signature 4 --twoside ' 	#to make pdf booklets. Execcute go into PDF Viewer and print to PDF by flip along long side. Everything will then to right side up.  $2up foo.pdf
alias wdiff='dwdiff' # diff program that operates at the word level instead of the line level.

# navigation
alias ..='cd ..' 
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# pacman and yay
alias pacsyu='sudo pacman -Syyu'                 	# update only standard pkgs
alias yaysua="yay -Sua --noconfirm"              	# update only AUR pkgs
alias yaysyu="yay -Syu --noconfirm"              	# update standard pkgs and AUR pkgs
alias unlock="sudo rm /var/lib/pacman/db.lck"    	# remove pacman lock
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)' 	# remove orphaned packages
#alias cleanup='pacman -Qtdq | pacman -Rns -' 	 	# same as above. 
						 	# if no orphans were found, the output is error: argument '-' specified with empty stdin. This is expected as no arguments were passed to pacman -Rns. 
alias cleancache='paccache -rk 2 && paccache -ruk0' 	# need pacman-contrib package
						   	# paccache -rk 2 will remove cache except current and previously cached packages
						    	# paccache -ruk0 remove cache of unistalled packages
#alias getpackages="sudo pacman -Qq | grep -v "$(pacman -Qqm)" | tr '\n' ' ' > ~/scripts/arch_packages_$(date +"%m.%d.%y").txt && sudo pacman -Qqm | tr '\n' ' ' > ~/scripts/aur_packages_$(date +"%m.%d.%y").txt" 	# create a list of packages for easy reinstall

alias keyring='pacman -Sy archlinux-keyring'	 # upgrade keyring to avoid package signing issues

# get fastest mirrors
alias mirror="sudo reflector --verbose --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
#alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
#alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
#alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
#alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
#alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias status='git status'
alias tag='git tag'
alias newtag='git tag -a'

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# xrandr to display outputs 
alias xrandr-right=xrandr --output HDMI-A-0 --left-of eDP #sets up extra monitor to be on left side

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# yt-dlp YouTube downloader
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"


