{ config, pkgs, ... }:

let npkgs = pkgs.nodePackages; in

{

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sweater";
  home.homeDirectory = "/home/sweater";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

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
  #  /etc/profiles/per-user/sweater/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages =
     [
        pkgs.jq
        pkgs.curl
        pkgs.imagemagick
        pkgs.nodejs-18_x
        npkgs.typescript
        npkgs.node-gyp
        pkgs.elan
        pkgs.go

        ## Used to work, but now is broken
        # npkgs.tsm
        # pkgs.httpie

        # Stuff that hasn't been yet confirmed to work
        ## I don't know how to find these binaries, but I'd like to have them:
        # pkgs.dd
        # pkgs.pv

        # Have to be externally configured:
        pkgs.gnupg
        pkgs.darcs
        pkgs.tmux

        ## To be packaged (by us?)
        # domaPakages.passveil

        # AtroNvim System Deps (we're installing nvim and astro in ad-hoc way)
        pkgs.tree-sitter
        pkgs.lazygit
        pkgs.bottom
        pkgs.luajitPackages.luarocks
        # NodeJS is installed anyway
        # NeoVim is installed as a binary release

        # Install fzf
        pkgs.fzf
        pkgs.fzf-obc
        pkgs.sysz
        pkgs.tmuxPlugins.tmux-fzf
    ];
}
