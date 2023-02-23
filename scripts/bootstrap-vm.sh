#! /bin/sh

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf groupupdate -y core
dnf groupupdate -y base-x
dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf groupupdate -y sound-and-video

dnf copr enable atim/lazygit -y

dnf install -y alacritty neovim bspwm sxhkd picom xsetroot chromium \
                xrandr ripgrep fd-find fzf lazygit gcc-c++ nodejs bash-completion \
                dbus-x11

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

sudo -u $SUDO_USER mkdir -p $USER_HOME/.config
sudo -u $SUDO_USER mkdir -p $USER_HOME/.config/bspwm
sudo -u $SUDO_USER mkdir -p $USER_HOME/.config/sxhkd
sudo -u $SUDO_USER mkdir -p $USER_HOME/.config/lazygit

rm -f $USER_HOME/.bashrc
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/bash/bashrc $USER_HOME/.bashrc

rm -f $USER_HOME/.xinitrc
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/xorg/xinitrc $USER_HOME/.xinitrc

rm -rf $USER_HOME/.fonts
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/fonts $USER_HOME/.fonts

rm -f $USER_HOME/.gitconfig
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/git/gitconfig $USER_HOME/.gitconfig

rm -rf $USER_HOME/.config/alacritty
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/alacritty $USER_HOME/.config/alacritty

rm -rf $USER_HOME/.config/bspwm/bspwmrc
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/bspwm/bspwmrc-vm $USER_HOME/.config/bspwm/bspwmrc

rm -rf $USER_HOME/.config/sxhkd/sxhkdrc
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/sxhkd/sxhkdrc-vm $USER_HOME/.config/sxhkd/sxhkdrc

rm -rf $USER_HOME/.config/picom
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/picom $USER_HOME/.config/picom

rm -rf $USER_HOME/.config/nvim
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/nvim $USER_HOME/.config/nvim

rm -f /usr/local/bin/vim
ln -s /usr/bin/nvim /usr/local/bin/vim

rm -f $USER_HOME/.config/lazygit/config.yml
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/lazygit/config.yml $USER_HOME/.config/lazygit/config.yml

rm -f $USER_HOME/.bash_profile
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/bash/bash_profile $USER_HOME/.bash_profile
