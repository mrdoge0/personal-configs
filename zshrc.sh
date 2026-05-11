## 
## ZSH CONFIG
## 

# Oh My Zsh Plugins
plugins=(git)

# Source the Oh my Zsh, if installed.
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="robbyrussell"
source ${ZSH}/oh-my-zsh.sh

# Source Zsh Syntax Highlighting
if [ -f '/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]; then
	source '/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
elif [ -f '/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]; then
	source '/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
fi

# Set distro
if [ -f '/system/build.prop' ]; then
	# Android
	SHDISTRO='Android'
elif [ -d '/nix/store' ]; then
	# NixOS
	SHDISTRO='NixOS'
elif [ -d '/System/Library' ]; then
	# macOS
	SHDISTRO='macOS'
else
	# Linux distros
	case "$(grep '^ID=' /etc/os-release | tr -d "\"\'" | cut -d'=' -f2)" in
		debian)    SHDISTRO='Debian'  ;;
		arch)      SHDISTRO='Arch'    ;;
		fedora)    SHDISTRO='Fedora'  ;;
		ubuntu)    SHDISTRO='Ubuntu'  ;;
		alpine)    SHDISTRO='Alpine'  ;;
		void)      SHDISTRO='Void'    ;;
		linuxmint) SHDISTRO='Mint'    ;;
		cachyos)   SHDISTRO='CachyOS' ;;
		gentoo)    SHDISTRO='Gentoo'  ;;
		nobara)    SHDISTRO='Nobara'  ;;
		*)         SHDISTRO='Unknown' ;;
	esac
fi

# Set accent color
case "${SHDISTRO}" in
	Android|Void|Mint|CachyOS) ACCENT='green'   ;;
	NixOS|Arch|Fedora|Alpine)  ACCENT='cyan'    ;;
	Debian|Ubuntu)             ACCENT='red'     ;;
	Gentoo|Nobara)             ACCENT='magenta' ;;
	macOS|Unknown|*)           ACCENT='white'   ;;
esac

# Custom prompt
PROMPT="%F{red}[%?]%f %F{$ACCENT}%n@%m%f %F{white}%~%f > "

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

# update-all and checkupdates-all aliases
alias u="update-all"
alias cu="checkupdates-all"

# Zsh quality of life improvement aliases
alias refresh="source ~/.zshrc;clear"
