# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.download-buffer-size = 536870912;
  nix.settings.warn-dirty = false;

  virtualisation.vmware.guest.enable = true;

  virtualisation.docker.enable = true;

  hardware.graphics.enable = true;

  environment.sessionVariables.GTK_THEME = "Adwaita:dark";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  boot.binfmt.emulatedSystems = if pkgs.system == "x86_64-linux"
    then [ "aarch64-linux" ]
    else [ "x86_64-linux" ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  xdg.portal.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  systemd.network.enable = true;

  networking = {
    hostName = "nixos";
    useNetworkd = true;
    firewall.enable = false;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
    autoLogin = {
      enable = true;
      user = "james";
    };
  };

  programs.niri.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.james = {
    isNormalUser = true;
    description = "James Russell";
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    git
    alacritty
    fuzzel
    clang
    fzf
    gemini-cli
    gnome-keyring
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    nautilus
    nixd
    (chromium.override {
      commandLineArgs = [
        "--password-store=basic"
      ];
    })
    nixos-generators
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
