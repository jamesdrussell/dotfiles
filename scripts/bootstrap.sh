#! /bin/sh

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install -y akmod-nvidia

dnf install -y fedora-workstation-repositories
dnf config-manager --set-enabled google-chrome
dnf copr enable atim/lazygit -y

dnf install -y alacritty neovim bspwm sxhkd picom xsetroot @base-x google-chrome-stable \
                xrandr ripgrep fd-find fzf lazygit gcc-c++ nodejs bash-completion playerctl \
                dbus-x11 xsecurelock xset xss-lock

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

mkdir -p $USER_HOME/.config
mkdir -p $USER_HOME/.config/lazygit

ln -sf $USER_HOME/projects/dotfiles/bash/bashrc $USER_HOME/.bashrc
ln -sf $USER_HOME/projects/dotfiles/xorg/xinitrc $USER_HOME/.xinitrc
ln -sf $USER_HOME/projects/dotfiles/fonts $USER_HOME/.fonts
ln -sf $USER_HOME/projects/dotfiles/git/gitconfig $USER_HOME/.gitconfig
ln -sf $USER_HOME/projects/dotfiles/alacritty $USER_HOME/.config/alacritty
ln -sf $USER_HOME/projects/dotfiles/bspwm $USER_HOME/.config/bspwm
ln -sf $USER_HOME/projects/dotfiles/sxhkd $USER_HOME/.config/sxhkd
ln -sf $USER_HOME/projects/dotfiles/picom $USER_HOME/.config/picom
ln -sf $USER_HOME/projects/dotfiles/nvim $USER_HOME/.config/nvim
ln -sf /usr/bin/nvim /usr/local/bin/vim
ln -sf $USER_HOME/projects/dotfiles/xorg/10-mouse.conf /etc/X11/xorg.conf.d/10-mouse.conf
ln -sf $USER_HOME/projects/dotfiles/lazygit/config.yml $USER_HOME/.config/lazygit/config.yml
ln -sf $USER_HOME/projects/dotfiles/bash/bash_profile $USER_HOME/.bash_profile
