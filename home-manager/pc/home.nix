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
  home.packages = with pkgs; [
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
    glow
    nixd
    spotify
    clang
    (google-chrome.override {
      commandLineArgs = [
        "--disable-features=GlobalShortcutsPortal"
        "--disable-notifications"
        "--hide-crash-restore-bubble"
      ];
    })
    _1password-cli
    _1password-gui
    jetbrains-mono
    nerd-fonts.symbols-only
  ];

  fonts.fontconfig.enable = true;

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
      bars = [];
      menu = "fuzzel";
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
        command = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 300;
        command = ''${pkgs.sway}/bin/swaymsg "output * power off"'';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "24273a";
      inside-color = "00000000";
    };
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
        settings = {
          options = {
            section_separators = "";
            component_separators = "";
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "" ];
            lualine_c = [ "filename" ];
            lualine_x = [ "" ];
            lualine_y = [ "" ];
            lualine_z = [ "" ];
          };
        };
      };
      neo-tree = {
        enable = true;
        defaultComponentConfigs = {
          gitStatus = {
            symbols = {
              added = "";
              deleted = "";
              renamed = "";
              modified = "";
              unstaged = "";
              untracked = "";
              ignored = "";
              staged = "";
              conflict = "";
            };
          };
        };
      };
      web-devicons = {
        enable = true;
      };
      fzf-lua = {
        enable = true;
        keymaps = {
          "<leader>f" = "files";
          "<leader>b" = "buffers";
        };
        settings = {
          winopts = {
            height = 0.25;
            preview = {
              hidden = "hidden";
            };
          };
          files = {
            winopts = {
              title_flags = false;
            };
            file_icons = false;
          };
          buffers = {
            no_header = true;
          };
        };
      };
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
          ts_config = {
            lua = [
              "string"
            ];
          };
        };
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
        settings = {
          auto_install = false;
          sync_install = false;
          highlight = {
            enable = true;
          };
          indent = {
            enable = true;
          };
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "gnn";
              node_decremental = "grm";
              node_incremental = "grn";
              scope_incremental = "grc";
            };
          };
        };
      };
      treesitter-textobjects = {
        enable = true;
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
          };
        };
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
      iskeyword = "-";
      laststatus = 3;
      showmode = false;
      showcmd = false;
      cmdheight = 1;
      hidden = true;
      shortmess = "I";
      foldmethod = "expr";
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
      foldcolumn = "0";
      foldtext = "";
      foldnestmax = 1;
      foldlevelstart = 1;
    };
    diagnostic = {
      settings = {
        virtual_text = false;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<cr>";
        options = {
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<cr>";
        options = {
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          silent = true;
        };
      }
      {
        mode = "n";
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options = {
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          silent = true;
        };
      }
    ];
  };

  programs.fzf = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
    enableBashIntegration = true;
    config = {
      global = {
        hide_env_diff = true;
        warn_timeout = 0;
      };
      whitelist = {
        prefix = [
          "~/projects/"
        ];
      };
    };
  };

  programs.gemini-cli = {
    enable = true;
    settings = {
      disableAutoUpdate = true;
      disableUpdateNag = true;
      selectedAuthType = "oauth-personal";
    };
  };

  programs.tmux = {
    enable = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      disableStartupPopups = true;
      gui = {
        showFileTree = false;
        showBottomLine = false;
        showCommandLog = false;
      };
    };
  };

  programs.lazydocker = {
    enable = true;
  };

  programs.zed-editor = {
    enable = true;
    userSettings = {
      theme = "Catppuccin Macchiato";
      buffer_font_family = "JetBrains Mono NL";
      buffer_font_size = 16;
      terminal = {
        font_size = 12;
      };
      vim_mode = false;
      cursor_blink = true;
      ensure_final_newline_on_save = false;
      format_on_save = "off";
      remove_trailing_whitespace_on_save = true;
      hover_popover_enabled = false;
      tab_size = 2;
      git = {
        inline_blame = {
          enabled = false;
        };
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      enable_language_server = true;
      show_wrap_guides = true;
      wrap_guides = [ 80 ];
      show_edit_predictions = false;
      gutter = {
        breakpoints = false;
        folds = false;
        runnables = false;
        min_line_number_digits = 3;
      };
      languages = {
        Nix = {
          language_servers = [ "nixd" "!nil" ];
        };
      };
    };
    userKeymaps = [
      {
        bindings = {
          ctrl-shift-tab = "pane::ActivatePreviousItem";
          ctrl-tab = "pane::ActivateNextItem";
        };
      }
    ];
    extensions = [
      "html"
      "just"
      "dockerfile"
      "toml"
      "kdl"
      "terraform"
      "git-firefly"
      "lua"
      "docker-compose"
      "meson"
      "nix"
      "pylsp"
      "sql"
      "swift"
      "proto"
      "make"
      "catppuccin"
    ];
  };

  services.easyeffects = {
    enable = true;
    preset = "Arctis-DF";
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      colors = {
        background = "24273aff";
        text = "cad3f5ff";
        prompt = "b8c0e0ff";
        placeholder = "8087a2ff";
        input = "cad3f5ff";
        match = "8aadf4ff";
        selection = "5b6078ff";
        selection-text = "cad3f5ff";
        selection-match = "8aadf4ff";
        counter = "8087a2ff";
        border = "8aadf4ff";
      };
      key-bindings = {
        next = "Control+j";
        prev = "Control+k";
        delete-line-forward = "none";
      };
    };
  };

}
