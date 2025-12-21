## 
## ZSH CONFIG
## 

# Oh My Zsh Plugins
plugins=(git)

# Source the Oh my Zsh, if installed.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

# Set accent color
if [ "$(which getprop)" != 'getprop not found' ] || [ ! -z $(cat /etc/os-release | grep 'ID=linuxmint') ] || [ ! -z $(cat /etc/os-release | grep 'ID=void') ]; then
	# Android, Linux Mint and Void Linux
	ACCENT=green
elif [ ! -z $(cat /etc/os-release | grep 'ID=arch') ] || [ ! -z $(cat /etc/os-release | grep 'ID=fedora') ]; then
	# Arch Linux and Fedora
	ACCENT=cyan
elif [ ! -z $(cat /etc/os-release | grep 'ID=debian') ] || [ ! -z $(cat /etc/os-release | grep 'ID=ubuntu') ]; then
	# Debian and Ubuntu
	ACCENT=red
elif [ ! -z $(cat /etc/os-release | grep 'ID=gentoo') ] || [ ! -z $(cat /etc/os-release | grep 'ID=nobara') ]; then
	# Gentoo and Nobara
	ACCENT=magenta
elif [ -d "/nix/store" ]; then
	# NixOS
	ACCENT=cyan
else
	# Other
	ACCENT=white
fi

# Custom prompt
PROMPT="%F{red}[%?]%f %F{$ACCENT}%n@%m%f %F{white}%~%f > "

# Add my NOS 4 port's project bin to PATH is exists on the machine
if [ -d '/media/2TB/NOS4-Port/bin' ]; then
	PATH="${PATH}:/media/2TB/NOS4-Port/bin"
fi

# LS aliases
alias ls="ls -lha --color=auto"
alias ll="ls -lha --color=auto"
alias dir="ls -lha --color=auto"

# Fastfetch and nerdfetch aliases
alias fastfetch="clear;fastfetch"
alias neofetch="clear;fastfetch"
alias nerdfetch="clear;nerdfetch"
alias ff="clear;fastfetch"
alias nf="clear;nerdfetch"

# Clear and exit aliases
alias cls="clear"
alias c="clear;"
alias ex="exit 0"
alias x="exit 0"
alias q="exit 0"
alias wq="exit"

# Sudo and SU aliases
alias s="sudo"
alias ss="sudo su"

# Neovim aliases
alias n="nvim"
alias sn="sudo nvim"
alias vim="nvim"
alias vi="nvim"

# Git aliases
alias g="git"
alias sg="sudo git"
alias gc="git clone --depth=1"
alias sgc="sudo git clone --depth=1"
alias gr="repo"
alias gri="repo init --depth=1"
alias grs="repo sync -j$(nproc --all)"

# Zsh quality of life improvement aliases
alias vizsh="nvim /opt/personal-configs/zshrc"
alias refresh="source ~/.zshrc;clear"
