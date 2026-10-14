{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils # SMB
    sbctl # Secure Boot
  ];

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Video
  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.kernelParams = [
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
  };

  # Audio
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # SMB mount (For mac access)
  fileSystems."/mnt/mac" = {
    device = "//192.168.0.189/firebain";
    fsType = "cifs";

    options = [
      "credentials=/etc/secrets/smb-credentials"
      "uid=1000"
      "gid=100"
      "vers=3.0"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };

  # Boot
  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = lib.mkForce false;
      configurationLimit = 3;
    };
  };

  # Disable "wake from suspend" from mouse
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c54d", TEST=="power/wakeup", ATTR{power/wakeup}="disabled"
  '';

  # Network
  networking.interfaces.enp8s0.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };

  # Secure Boot
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
