{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "james";
  home.homeDirectory = "/home/james";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/james/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
    sway.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    extraOptions = [
      "--unsupported-gpu"
    ];
    config = rec {
      modifier = "Mod1";
      terminal = "alacritty";
      defaultWorkspace = "workspace number 1";
      output = {
        "DP-1" = {
          mode = "2560x1440@359.979Hz";
	};
      };
      input = {
        "type:pointer" = {
          pointer_accel = "-0.5";
	};
      };
      keybindings = lib.mkOptionDefault {
        "${modifier}+t" = "exec ${terminal}";
        "${modifier}+b" = "exec google-chrome-stable";
      };
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        event = "after-resume";
        command = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 300;
        command = ''${pkgs.sway}/bin/swaymsg "output * dpms off"'';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

  programs.swaylock = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "James Russell";
    userEmail = "jamesdrus@gmail.com";
  };

  programs.alacritty = {
    enable = true;
    theme = "catppuccin_macchiato";
    settings = {
      font.size = 12.0;
      font.normal = {
        family = "JetBrains Mono NL";
        style = "Regular";
      };
      window.padding = {
        x = 4;
        y = 4;
      };
      env.TERM = "xterm-256color";
    };
  };

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "macchiato";
      };
    };
    globals.mapleader = " ";
    plugins = {
      lualine = {
        enable = true;
      };
      neo-tree = {
        enable = true;
      };
      web-devicons = {
        enable = true;
      };
      fzf-lua = {
        enable = true;
      };
      nvim-autopairs = {
        enable = true;
      };
      gitsigns = {
        enable = true;
      };
      nvim-surround = {
        enable = true;
      };
      flash = {
        enable = true;
      };
      comment = {
        enable = true;
      };
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          cmake
          cpp
          json
          kdl
          lua
          make
          markdown
          markdown_inline
          nix
          python
          toml
          vim
          vimdoc
          yaml
        ];
      };
    };
    opts = {
      number = true;
      relativenumber = false;
      wrap = false;
      mouse = "a";
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      hlsearch = false;
      incsearch = true;
      ignorecase = true;
      smartcase = true;
      cursorline = true;
      termguicolors = true;
      background = "dark";
      signcolumn = "yes";
      scrolloff = 5;
      backspace = "indent,eol,start";
      clipboard = "unnamedplus";
      splitright = true;
      splitbelow = true;
      laststatus = 3;
      showmode = false;
      showcmd = false;
      cmdheight = 1;
      hidden = true;
      shortmess = "I";
    };
  };
}
