## 
## ZSH CONFIG
## 

# Oh My Zsh Plugins
plugins=(git)

# Source the Oh my Zsh, if installed.
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME='robbyrussell'
[ -d "${ZSH}/oh-my-zsh.sh" ] && source "${ZSH}/oh-my-zsh.sh"

# Source Zsh Syntax Highlighting
for HIGHLPATH in '/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' '/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'; do
	[ -f "${HIGHLPATH}" ] && source "${HIGHLPATH}"
done

# Source Zsh Auto Suggestions
for SUGGPATH in '/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' '/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh'; do
	[ -f "${SUGGPATH}" ] && source "${SUGGPATH}"
done

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
		antix)     SHDISTRO='antiX'   ;;
		pardus)    SHDISTRO='Pardus'  ;;
		*)         SHDISTRO='Unknown' ;;
	esac
fi

# Set accent color
case "${SHDISTRO}" in
	Android|Void|Mint|CachyOS) ACCENT='green'   ;;
	NixOS|Arch|Fedora|Alpine)  ACCENT='cyan'    ;;
	Debian|Ubuntu)             ACCENT='red'     ;;
	Gentoo|Nobara)             ACCENT='magenta' ;;
	antiX|Pardus)              ACCENT='yellow'  ;;
	macOS|Unknown|*)           ACCENT='white'   ;;
esac

# Custom prompt
PROMPT="%F{red}[%?]%f %F{$ACCENT}%n@%m%f %F{white}%~%f > "

# Set Fastfetch command
case "${SHDISTRO}" in
	Android) FASTFETCH_COMMAND='clear && /data/data/com.termux/files/usr/bin/fastfetch -c /data/data/com.termux/files/home/.pc/fastfetch/android-termux/logo.jsonc && /data/data/com.termux/files/usr/bin/fastfetch -c /data/data/com.termux/files/home/.pc/fastfetch/android-termux/main.jsonc' ;;
	*)       FASTFETCH_COMMAND='clear && fastfetch' ;;
esac

# Do Fastfetch command override if set in environment
[ ! -z "${FASTFETCH_COMMAND_OVERRIDE}" ] && FASTFETCH_COMMAND="${FASTFETCH_COMMAND_OVERRIDE}"

# Replace ls with lsd if possible
if which 'lsd' > /dev/null; then
	LS_COMMAND='lsd -lha --color=auto'
else
	LS_COMMAND='ls -lha --color=auto'
fi

# LS aliases
alias ls="${LS_COMMAND}"
alias ll="${LS_COMMAND}"
alias dir="${LS_COMMAND}"
alias lsd="${LS_COMMAND}"

# Fastfetch and nerdfetch aliases
alias fastfetch="${FASTFETCH_COMMAND}"
alias neofetch="${FASTFETCH_COMMAND}"
alias nerdfetch='clear;nerdfetch'
alias ff="${FASTFETCH_COMMAND}"
alias nf='clear;nerdfetch'

# Clear and exit aliases
alias cls='clear'
alias c='clear;'
alias ex='exit 0'
alias x='exit 0'
alias q='exit 0'
alias wq='exit'

# Sudo and SU aliases
alias s='sudo'
alias ss='sudo su'

# Neovim aliases
alias n='nvim'
alias sn='sudo nvim'
alias vim='nvim'
alias vi='nvim'

# Git aliases
alias g='git'
alias sg='sudo git'
alias gc='git clone --depth=1'
alias sgc='sudo git clone --depth=1'
alias gr='repo'
alias gri='repo init --depth=1'
alias grs="repo sync -j$(nproc --all)"

# update-all and checkupdates-all aliases
alias u='update-all'
alias cu='checkupdates-all'

# Zsh quality of life improvement aliases
alias refresh='source ~/.zshrc'
