termux-setup-storage
yes | pkg update -y && yes | pkg upgrade -y
yes | pkg install python-pip -y
pip install selenium==4.9.1
###

#chromium
yes | pkg install x11-repo -y
yes | pkg install tur-repo -y
yes | pkg install chromium -y
###

#firefox
yes | pkg install x11-repo -y
yes | pkg install firefox -y
yes | pkg install geckodriver -y
###


#vncserver
termux-setup-storage
sleep 1
clear 
yes | pkg update
cd $HOME

pkg upgrade
pkg install wget -y
rm $PREFIX/etc/apt/sources.list.d/termux-desktop-xfce.list
wget -P $PREFIX/etc/apt/sources.list.d https://raw.githubusercontent.com/Yisus7u7/termux-desktop-xfce/gh-pages/termux-desktop-xfce.list
yes | pkg update
pkg upgrade
pkg install x11-repo -y
pkg install xfce4 tigervnc xfce4-goodies termux-desktop-xfce ttf-microsoft-cascadia pavucontrol-qt firefox -y

rm -rf .vnc
mkdir .vnc
echo -e 'xfce4-session &\nxhost + &' >> .vnc/xstartup
chmod +x .vnc/xstartup
#echo 'geometry=1050x2150' >> .vnc/config
mkdir Desktop 
mkdir Downloads 
mkdir Templates 
mkdir Public 
mkdir Documents 
mkdir Pictures 
mkdir Videos 

rm $PREFIX/bin/s &> /dev/null
rm $PREFIX/bin/p &> /dev/null
echo -e 'vncserver :1 -SecurityTypes None -localhost no' > $PREFIX/bin/p
echo -e 'printf "\033[5;31mokeh🙋\\n"\nvncserver -kill :1 &> /dev/null\nvncserver -kill :2 &> /dev/null\nrm ~/.vnc/*.log &> /dev/null\nrm ~/.vnc/*.pid &> /dev/null' >> $PREFIX/bin/s
chmod +x $PREFIX/bin/s
chmod +x $PREFIX/bin/p

downloader(){
	path="$1"
	[[ -e "$path" ]] && rm -rf "$path"
	printf "\033[5;32m"
	curl --progress-bar --insecure --fail \
		 --retry-connrefused --retry 3 --retry-delay 2 \
		  --location --output ${path} "$2"
printf "\033[0m"
}
rm -rf $HOME/.config &> /dev/null
rm -rf $PREFIX/share/backgrounds &> /dev/null
rm -rf $PREFIX/share/icons &> /dev/null
rm -rf $PREFIX/share/themes &> /dev/null
downloader "backgrounds.zip" "https://github.com/R1PAN/termux-desktop/releases/download/v1.0.0/backgrounds.zip"
downloader "config.zip" "https://github.com/R1PAN/termux-desktop/releases/download/v1.0.0/config.zip"
downloader "icons.zip" "https://github.com/R1PAN/termux-desktop/releases/download/v1.0.0/icons.zip"
downloader "themes.zip" "https://github.com/R1PAN/termux-desktop/releases/download/v1.0.0/themes.zip"
unzip -o backgrounds.zip
unzip -o config.zip
unzip -o icons.zip
unzip -o themes.zip
mv backgrounds $PREFIX/share/
mv .config $HOME
mv icons $PREFIX/share/
mv themes $PREFIX/share/
rm -rf backgrounds.zip config.zip icons.zip themes.zip



#puppeteer
pkg install yarn -y
git clone https://github.com/rishabhrpg/puppeteer-on-termux.git
cd puppeteer-on-termux
yarn install
node index.js




###






rm ~/.bashrc &> /dev/null
DEFAULT_PA=.bashrc
        cat > $DEFAULT_PA <<- EOF
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case \$- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

color_prompt=yes
# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "\$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    prompt_symbol=_ #㉿
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
        prompt_color='\[\033[;94m\]'
        info_color='\[\033[1;31m\]'
        # Skull emoji for root terminal
        #prompt_symbol=💀
    fi
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PS1=\$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'\$prompt_color')}('\$info_color'Termux'\$prompt_symbol'\h'\$prompt_color')-[\[\033[0;1m\]\w'\$prompt_color']\n'\$prompt_color'└─'\$info_color'\$\[\033[0m\] ';;
        oneline)
            PS1='\${VIRTUAL_ENV:+(\$(basename \$VIRTUAL_ENV)) }\${debian_chroot:+(\$debian_chroot)}'\$info_color'Termux@\h\[\033[00m\]:'\$prompt_color'\[\033[01m\]\w\[\033[00m\]\$ ';;
        backtrack)
            PS1='\${VIRTUAL_ENV:+(\$(basename \$VIRTUAL_ENV)) }\${debian_chroot:+(\$debian_chroot)}\[\033[01;31m\]Termux@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ';;
    esac
    unset prompt_color
    unset info_color
    unset prompt_symbol
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir


[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f $PREFIX/share/bash-completion/bash_completion ]; then
    . $PREFIX/share/bash-completion/bash_completion
  elif [ -f $PREFIX/bash_completion ]; then
    . $PREFIX/bash_completion
  fi
fi


if [ -f ~/.bash_history ]; then
    file_mtime=\$(stat -c %Y ~/.bash_history)
    current_time=\$(date +%s)
    time_threshold=270
    time_diff=\$((current_time - file_mtime))

    if [ \$time_diff -ge \$time_threshold ]; then
        rm ~/.bash_history &> /dev/null
        touch ~/.bash_history
    fi
fi
EOF
printf "\033[5;32m[!]Login Ulang\n"
sleep 1
for countdown in  🙈 🙉 🙈 🙉 🙈 🙉 🙈 🙉 🙈 🙉 🙈 🙉 🙈 🙉; do
    echo -ne "\r\033[5;34mHitung Mundur \033[5;33m$countdown"
    sleep 0.4
done 
kill $PPID
