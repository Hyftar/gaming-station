{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
  };

  services.desktopManager.plasma6.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # needed for Steam/most games via Proton
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver.xkb.options = "compose:ralt";

  environment.systemPackages = with pkgs; [
    firefox
    kdePackages.ark
    kdePackages.spectacle
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
  ];
}