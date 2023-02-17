#! /bin/sh

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install -y akmod-nvidia

dnf install -y fedora-workstation-repositories
dnf config-manager --sfet-enabled google-chrome
dnf copr enable atim/lazygit -y

dnf install -y alacritty neovim bspwm sxhkd picom xsetroot @base-x git google-chrome-stable \
                xrandr ripgrep fd-find fzf lazygit gcc-c++ nodejs bash-completion playerctl \
                dbus-x11 xsecurelock xset xss-lock

git clone git@github.com:jamesdrussell/dotfiles.git ~/projects/dotfiles

ln -sf ~/projects/dotfiles/xorg/xinitrc ~/.xinitrc
ln -sf ~/projects/dotfiles/fonts ~/.fonts
ln -sf ~/projects/dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/projects/dotfiles/alacritty ~/.config/alacritty
ln -sf ~/projects/dotfiles/bspwm ~/.config/bspwm
ln -sf ~/projects/dotfiles/sxhkd ~/.config/sxhkd
ln -sf ~/projects/dotfiles/picom ~/.config/picom
ln -sf ~/projects/dotfiles/nvim ~/.config/nvim
ln -sf /usr/bin/nvim /usr/local/bin/vim
ln -sf ~/projects/dotfiles/xorg/10-mouse.conf /etc/X11/xorg.conf.d/10-mouse.conf
ln -sf ~/projects/dotfiles/lazygit/config.yml ~/.config/lazygit/config.yml
ln -sf ~/projects/dotfiles/bash/bash_profile ~/.bash_profile
