#! /bin/sh

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf groupupdate -y core
sudo dnf groupupdate -y base-x
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate -y sound-and-video

dnf copr enable atim/lazygit -y

dnf install -y alacritty neovim bspwm sxhkd picom xsetroot chromium \
                ripgrep fd-find fzf lazygit gcc-c++ nodejs bash-completion \
                dbus-x11

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

mkdir -p $USER_HOME/.config
mkdir -p $USER_HOME/.config/sxhkd
mkdir -p $USER_HOME/.config/lazygit

rm -f $USER_HOME/.bashrc
ln -s $USER_HOME/projects/dotfiles/bash/bashrc $USER_HOME/.bashrc

rm -f $USER_HOME/.xinitrc
ln -s $USER_HOME/projects/dotfiles/xorg/xinitrc $USER_HOME/.xinitrc

rm -rf $USER_HOME/.fonts
ln -s $USER_HOME/projects/dotfiles/fonts $USER_HOME/.fonts

rm -f $USER_HOME/.gitconfig
ln -s $USER_HOME/projects/dotfiles/git/gitconfig $USER_HOME/.gitconfig

rm -rf $USER_HOME/.config/alacritty
ln -s $USER_HOME/projects/dotfiles/alacritty $USER_HOME/.config/alacritty

rm -rf $USER_HOME/.config/bspwm
ln -s $USER_HOME/projects/dotfiles/bspwm $USER_HOME/.config/bspwm

rm -rf $USER_HOME/.config/sxhkd
if [[ $(uname -m) == "x86_64" ]]; then
    ln -s $USER_HOME/projects/dotfiles/sxhkd-win $USER_HOME/.config/sxhkd
elif [[ $(uname -m) == "aarch64" ]]; then
    ln -s $USER_HOME/projects/dotfiles/sxhkd-mac $USER_HOME/.config/sxhkd
fi

rm -rf $USER_HOME/.config/picom
ln -s $USER_HOME/projects/dotfiles/picom $USER_HOME/.config/picom

rm -rf $USER_HOME/.config/nvim
ln -s $USER_HOME/projects/dotfiles/nvim $USER_HOME/.config/nvim

rm -f /usr/local/bin/vim
ln -s /usr/bin/nvim /usr/local/bin/vim

rm -f /etc/X11/xorg.conf.d/10-mouse.conf
ln -s $USER_HOME/projects/dotfiles/xorg/10-mouse.conf /etc/X11/xorg.conf.d/10-mouse.conf

rm -f $USER_HOME/.config/lazygit/config.yml
ln -s $USER_HOME/projects/dotfiles/lazygit/config.yml $USER_HOME/.config/lazygit/config.yml

rm -f $USER_HOME/.bash_profile
ln -s $USER_HOME/projects/dotfiles/bash/bash_profile $USER_HOME/.bash_profile
