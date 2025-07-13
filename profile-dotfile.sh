## 
## PROFILE.D ENVIRONMENT MODDING
## 

# Add the user's '~/.local/bin', and '/opt/personal-configs/bin' to PATH.
export PATH="${PATH}:/opt/personal-configs/bin:${HOME}/.local/bin"

# Export that I'm a nerd :D
export EDITOR=nvim

# Set qt6ct as Qt5/6 theme provider if the DE is not KDE Plasma.
if [ ! -f "/usr/share/wayland-sessions/*plasma*.desktop" ]; then
  export QT_QPA_PLATFORMTHEME=qt6ct
fi

# Mkdir the '~/.local/bin's for everyone
if [ ! -d "${HOME}/.local/bin" ]; then
  mkdir -p "${HOME}/.local/bin"
fi

# Install zshrc shim to everyone.
if [ "$(cat ${HOME}/.zshrc)" -ne "source /opt/personal-configs/zshrc" ]; then
  echo "source /opt/personal-configs/zshrc" > ${HOME}/.zshrc
fi
