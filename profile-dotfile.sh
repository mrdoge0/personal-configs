## 
## PROFILE.D ENVIRONMENT MODDING
## 

# Add the user's ~/.local/bin to PATH.
export PATH="${PATH}:${HOME}/.local/bin"

# Export that I'm a nerd :D
export EDITOR=nvim

# Set qt6ct as Qt5/6 theme provider if the DE is not KDE Plasma.
if [ ! -f "/usr/share/wayland-sessions/*plasma*.desktop" ]; then
  export QT_QPA_PLATFORMTHEME=qt6ct
fi
