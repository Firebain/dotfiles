{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    alacritty
    yazi 
    wl-clipboard
    opencode
    claude-code
    adwaita-icon-theme
    stow
    unzip
    gnumake
    file
    tree-sitter
    bitwarden-desktop
    ripgrep

    nodejs
    go
    gcc
    rustc
    cargo
    rustfmt
    clippy

    slack
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.nix-ld.enable = true;

  virtualisation.docker.enable = true;
}
