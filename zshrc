## 
## ZSH CONFIG
## 

# Source the Oh my Zsh, if installed.
#(will be added)

# Set accent color
if [ ! -z $(cat /etc/os-release | grep 'ID=linuxmint') ] || [ ! -z $(cat /etc/os-release | grep 'ID=void') ]; then
	# Linux Mint and Void Linux
	ACCENT=green
elif [ ! -z $(cat /etc/os-release | grep 'ID=archlinux') ] || [ ! -z $(cat /etc/os-release | grep 'ID=fedora') ]; then
	# Arch Linux and Fedora
	ACCENT=cyan
elif [ ! -z $(cat /etc/os-release | grep 'ID=debian') ] || [ ! -z $(cat /etc/os-release | grep 'ID=ubuntu') ]; then
	# Debian and Ubuntu
	ACCENT=red
else
	# Other
	ACCENT=white
fi

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
