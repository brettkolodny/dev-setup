{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "brettkolodny";
  home.homeDirectory = "/Users/brettkolodny";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    helix
    bat
    cheat
    deno
    emacs
    openssl
    pkg-config
    rustc
    cargo
    cargo-deny
    cargo-edit
    cargo-watch
    rust-analyzer
    git-town
  ];

  programs.helix = {
    enable = true;

    settings = {
      # theme = "playdate_morning";
      theme = "dark_plus";

      editor = {
        mouse = true;
        scroll-lines = 6;
        bufferline = "multiple";
        undercurl = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true;
        };

        soft-wrap = {
          enable = true;
        };
      };
    };

    languages = {
      language = [
        {
          name = "gleam";
          auto-format = true;
          formatter = {
            command = "gleam";
            args = ["format" "--stdin"];
          };
        }
        {
          name = "typescript";
          language-id = "typescript";
          scope = "source.ts";
          injection-regex = "^(ts|typescript)$";
          file-types = ["ts" "js"];
          shebangs = ["deno"];
          # roots = ["deno.json" "deno.jsonc" "package.json"];
          language-servers = ["deno-lsp"];
        }
        {
          name = "tsx";
          scope = "source.tsx";
          injection-regex = "^(tsx)$";
          file-types = ["tsx"];
          shebangs = ["deno" "node"];
          roots = ["deno.json" "package.json" "tsconfig.json"];
          language-servers = ["deno-lsp"];
          indent = {
            tab-width = 2;
            unit = "  ";
          };
        }
      ];
  
      grammar = [
        {
          name = "gleam";
          source = {
            git = "https://github.com/gleam-lang/tree-sitter-gleam";
            rev = "426e67087fd62be5f4533581b5916b2cf010fb5b";
          };
        }
      ];

      language-server = {
        deno-lsp = {
          command = "deno";
          args = ["lsp"];
        };
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      eval "$(${pkgs.starship}/bin/starship init bash)"
      export PATH="/Users/brettkolodny/.deno/bin:$PATH"
      export PATH="/Users/brettkolodny/bin:$PATH"
      export PATH="/Users/brettkolodny/go/bin:$PATH"
      export PATH="/Users/brettkolodny/.cargo/bin:$PATH"
      export EDITOR=hx
      alias weather="curl https://wttr.in/"
    '';
  };

  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

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
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/brettkolodny/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    editor = "hx";
    EDITOR = "hx";
    VISUAL = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
