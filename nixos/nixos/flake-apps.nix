{ inputs, pkgs, ... }:

{
  imports = [
    inputs.noctalia.nixosModules.default
    inputs.noctalia-greeter.nixosModules.default
    inputs.helium.nixosModules.default
  ];

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  services.displayManager.noctalia-greeter = {
    enable = true;
    cursorTheme.package = pkgs.adwaita-icon-theme;

    settings = {
      user.default = "firebain";

      cursor = {
        theme = "Adwaita";
        size = 24;
      };

      appearance = {
        scheme = "Synced";
	      theme_mode = "dark";
      };
    };
  };

  environment.systemPackages = with inputs; [
    (herdr.packages.${pkgs.system}.default)
  ];

  programs.helium.enable = true;
}
