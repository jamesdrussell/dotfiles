#! /bin/sh

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install -y akmod-nvidia
systemctl disable nvidia-powerd.service

dnf groupupdate -y core
dnf groupupdate -y base-x
dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf groupupdate -y sound-and-video

dnf install -y fedora-workstation-repositories
dnf config-manager --set-enabled google-chrome
dnf copr enable atim/lazygit -y

dnf install -y alacritty neovim bspwm sxhkd picom xsetroot google-chrome-stable \
                xrandr ripgrep fd-find fzf lazygit gcc-c++ nodejs bash-completion \
                playerctl dbus-x11 xsecurelock xset xss-lock flatpak dmenu libxkbcommon-x11

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.spotify.Client

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

sudo -u $SUDO_USER mkdir -p $USER_HOME/.config
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

rm -rf $USER_HOME/.config/bspwm
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/bspwm $USER_HOME/.config/bspwm

rm -rf $USER_HOME/.config/sxhkd
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/sxhkd $USER_HOME/.config/sxhkd

rm -rf $USER_HOME/.config/picom
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/picom $USER_HOME/.config/picom

rm -rf $USER_HOME/.config/nvim
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/nvim $USER_HOME/.config/nvim

rm -f /usr/local/bin/vim
ln -s /usr/bin/nvim /usr/local/bin/vim

rm -f /usr/local/bin/spotify
ln -s /var/lib/flatpak/exports/bin/com.spotify.Client /usr/local/bin/spotify

rm -f /etc/X11/xorg.conf.d/10-mouse.conf
ln -s $USER_HOME/projects/dotfiles/xorg/10-mouse.conf /etc/X11/xorg.conf.d/10-mouse.conf

rm -f $USER_HOME/.config/lazygit/config.yml
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/lazygit/config.yml $USER_HOME/.config/lazygit/config.yml

rm -f $USER_HOME/.bash_profile
sudo -u $SUDO_USER ln -s $USER_HOME/projects/dotfiles/bash/bash_profile $USER_HOME/.bash_profile
