{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "james";
  home.homeDirectory = "/Users/james";

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
    nixd
    ghostty-bin
    clang
    glow
    jetbrains-mono
    nerd-fonts.symbols-only
    _1password-cli
    cmake
    just
    ninja
    terraform
    python3
    difftastic
    tart
  ];

  fonts.fontconfig.enable = true;

  xdg.enable = true;

  xdg.configFile."ghostty/config".text = ''
    theme = Catppuccin Macchiato
    font-family = "JetBrains Mono NL"
    font-size = 15
    shell-integration-features = sudo
    resize-overlay = "never"
    macos-titlebar-proxy-icon = "hidden"
    quit-after-last-window-closed = true
    window-save-state = "always"
  '';

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
    ".hushlogin".text = "";
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  launchd.agents = {
    tart = {
      enable = true;
      config = {
        ProgramArguments = [
          "${pkgs.tart}/bin/tart"
          "run"
          "nixos"
          "--no-graphics"
          "--no-audio"
          "--no-clipboard"
        ];
        RunAtLoad = true;
        KeepAlive = false;
      };
    };
  };

  programs.zsh = {
    enable = true;
    initContent = ''
      PROMPT='%n@%m %1~ %# '
    '';
    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gp = "git push";
      gs = "git status";
      gg = "lazygit";
      vm = "tart";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "vm" = {
        hostname = "192.168.64.2";
        user = "james";
        identityFile = "~/.ssh/id_ed25519";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new -A -s 0";
        };
      };
      "vm-no-tmux" = {
        hostname = "192.168.64.2";
        user = "james";
        identityFile = "~/.ssh/id_ed25519";
      };
      "pc" = {
        hostname = "192.168.50.84";
        user = "james";
        identityFile = "~/.ssh/id_ed25519";
        extraOptions = {
          RequestTTY = "yes";
          RemoteCommand = "tmux new -A -s 0";
        };
      };
      "home-server" = {
        hostname = "192.168.50.168";
        user = "james";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "James Russell";
    userEmail = "jamesdrus@gmail.com";
    lfs = {
      enable = true;
    };
    extraConfig = {
      diff.external = "difft --color=always --display=inline --syntax-highlight=off";
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
    enableZshIntegration = true;
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
    shortcut = "a";
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 1;
    disableConfirmationPrompt = true;
    terminal = "tmux-256color";
    mouse = true;
    extraConfig = ''
      set -as terminal-features ",xterm-256color:RGB"
      set-option -g renumber-windows on
      set -g status off
      set-option -g status-right ""
      unbind %
      bind \\ split-window -h
      unbind '"'
      bind - split-window -v
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind i set-option -g status
      unbind -T copy-mode-vi MouseDragEnd1Pane
      bind Escape copy-mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
    '';
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
      git = {
        autoFetch = false;
        paging = {
          externalDiffCommand = "difft --color=always --display=inline --syntax-highlight=off";
        };
      };
    };
  };

  programs.lazydocker = {
    enable = true;
    settings = {
      gui = {
        showBottomLine = false;
      };
    };
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
      ssh_connections = [
        {
          host = "vm-no-tmux";
          nickname = "vm";
          projects = [
            {
              paths = [
                "~/projects"
              ];
            }
          ];
        }
      ];
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

  programs.uv = {
    enable = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.fd = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };
}
