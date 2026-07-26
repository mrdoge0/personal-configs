## 
## ZSH CONFIG
## 

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

# Set up Zsh Completions
autoload -U compinit
compinit

# Source Zsh Syntax Highlighting
for SC in '/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' '/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' '/usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh'; do
	[ -f "${SC}" ] && source "${SC}"
done

# Source Zsh Auto Suggestions
for SC in '/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' '/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh' '/usr/share/zsh/site-functions/zsh-autosuggestions.zsh'; do
	[ -f "${SC}" ] && source "${SC}"
done

# Source Zsh Autocomplete
for SC in '/usr/share/zsh/site-functions/zsh-autocomplete/zsh-autocomplete.plugin.zsh'; do
	[ -f "${SC}" ] && source "${SC}"
done

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
alias l="${LS_COMMAND}"

# Fastfetch and nerdfetch aliases
alias fastfetch="${FASTFETCH_COMMAND}"
alias neofetch="${FASTFETCH_COMMAND}"
alias nerdfetch='clear;nerdfetch'
alias ff="${FASTFETCH_COMMAND}"
alias f="${FASTFETCH_COMMAND}"
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
alias gp='git pull'
alias sgp='sudo git pull'
alias gr='repo'
alias gri='repo init --depth=1'
alias grs="repo sync -j$(nproc --all)"

# update-all and checkupdates-all aliases
alias u='update-all'
alias cu='checkupdates-all'

# Zsh quality of life improvement aliases
alias refresh='cd ~/.pc && git pull && cd ~ && source ~/.zshrc'
alias vizsh='echo "use github you dumbass" && false'

# The system update command (no, this code is not AI SLoP, and it is a real mental illness.)
case ${SHDISTRO} in
	Debian|Ubuntu|Mint|antiX|Pardus) UPDATER_COMMAND='echo "########################" && echo "# SYNCING APT REPOS... #" && echo "########################" && echo " > sudo apt update" && sudo apt update && echo "" && echo "#############################" && echo "# UPGRADING APT PACKAGES... #" && echo "#############################" && echo " > sudo apt full-upgrade" && sudo apt full-upgrade && echo "" && echo "###################################" && echo "# REMOVING UNUSED APT PACKAGES... #" && echo "###################################" && echo " > sudo apt autoremove" && sudo apt autoremove';;
	Arch|CachyOS)                    UPDATER_COMMAND='echo "####################################" && echo "# UPGRADING PACMAN/AUR PACKAGES... #" && echo "####################################" && echo " > yay -Syu" && yay -Syu';;
	Gentoo)                          UPDATER_COMMAND='echo "############################" && echo "# SYNCING PORTAGE REPOS... #" && echo "############################" && echo " > sudo emaint -a sync" && sudo emaint -a sync && echo "" && echo "#################################" && echo "# UPGRADING PORTAGE PACKAGES... #" && echo "#################################" && echo " > sudo emerge -avuDN --with-bdeps=y @world" && sudo emerge -avuDN --with-bdeps=y @world';;
	Alpine)                          UPDATER_COMMAND='echo "########################" && echo "# SYNCING APK REPOS... #" && echo "########################" && echo " > sudo apk update" && sudo apk update && echo "" && echo "#############################" && echo "# UPGRADING APK PACKAGES... #" && echo "#############################" && echo " > sudo apk upgrade" && sudo apk upgrade';;
	Void)                            UPDATER_COMMAND='echo "##############################" && echo "# UPGRADING XBPS PACKAGES... #" && echo "##############################" && echo " > sudo xbps-install -Syu" && sudo xbps-install -Syu';;
	*)                               UPDATER_COMMAND='true';; # for sanity's sake
esac
which flatpak > /dev/null && UPDATER_COMMAND="${UPDATER_COMMAND} && echo '#################################' && echo '# UPGRADING FLATPAK PACKAGES... #' && echo '#################################' && echo ' > flatpak update' && flatpak update && echo '' && echo '#######################################' && echo '# REMOVING UNUSED FLATPAK PACKAGES... #' && echo '#######################################' && echo ' > flatpak remove --unused' && flatpak remove --unused"
which snap > /dev/null && UPDATER_COMMAND="${UPDATER_COMMAND} && echo '##############################' && echo '# UPGRADING SNAP PACKAGES... #' && echo '##############################' && echo ' > sudo snap refresh' && sudo snap refresh"
UPDATER_COMMAND="${UPDATER_COMMAND} && echo '' && echo '################' && echo '# DONE, ENJOY. #' && echo '################'"
alias update-all="${UPDATER_COMMAND}"
alias u="${UPDATER_COMMAND}"
