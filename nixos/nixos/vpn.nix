{ pkgs, config, ... }:

let 
  amneziawg-kmod =
    config.boot.kernelPackages.amneziawg.overrideAttrs (_: rec {
      version = "3.1.20260828";

      src = pkgs.fetchFromGitHub {
        owner = "amnezia-vpn";
        repo = "amneziawg-linux-kernel-module";
        tag = "v${version}";
        hash = "sha256-AFcbDRM+rzR6Pz0MMUMWaphhKwVQ1A1uUnjy03kXbxk=";
      };
    });

  amneziawg-tools =
    pkgs.amneziawg-tools.overrideAttrs (_: rec {
      version = "3.1.20260812";

      src = pkgs.fetchFromGitHub {
        owner = "amnezia-vpn";
        repo = "amneziawg-tools";
        tag = "v${version}";
        hash = "sha256-6GEb41ERhR0Hg3RbSyIHdXPSKaxugoFCmFS5S0UiZso=";
      };
    });
in
{
  environment.systemPackages = with pkgs; [
    amneziawg-tools
    pritunl-client
  ];

  systemd.packages = with pkgs; [
    pritunl-client
  ];

  systemd.services.pritunl-client.wantedBy = [
    "multi-user.target"
  ];

  boot.extraModulePackages = [
    amneziawg-kmod
  ];

  boot.kernelModules = [
    "amneziawg"
  ];
}
