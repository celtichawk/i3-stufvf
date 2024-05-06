# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
./hardware-configuration.nix
#<kde2nix/nixos.nix>
#<home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
boot.plymouth.enable = true;
boot.plymouth.theme = "solar";
#boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
hardware.enableAllFirmware = true;
hardware.firmware = [ pkgs.sof-firmware ];
nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "tigers-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
services.gvfs.enable = true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
services.xserver.displayManager.lightdm.greeters.slick.enable = true;
#services.xserver.displayManager.sddm.wayland.enable = true;
services.xserver.desktopManager.mate.enable = true;
#services.xserver.desktopManager.gnome.enable = true;

#services.xserver.desktopManager.plasma6.enable = true;
systemd.services."getty@tty1".enable = false;
systemd.services."autovt@tty1".enable = false;
services.xserver.displayManager.defaultSession = "mate";
services.gnome.at-spi2-core.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
environment.variables = {
GTK_MODULES = "gail:atk-bridge:canberra-gtk-module";
ACCESSIBILITY_ENABLED = "1";
};
#   virtualisation.virtualbox.host.enable = true;
#   virtualisation.virtualbox.host.enableExtensionPack = true;
#virtualisation.docker.enable = true;
  virtualisation.containers.enable = true;
#virtualisation = {
#    podman = {
#      enable = true;
#virtualisation = {
#      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
#      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
#      defaultNetwork.settings.dns_enabled = true;
#    };
#  };
  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;
hardware.opengl = {
enable = true;
driSupport = true;
driSupport32Bit = true;
  };
#hardware.nvidia = {

    # Modesetting is required.
#    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
#    powerManagement.enable = false;
#package = config.boot.kernelPackages.nvidiaPackages.stable;
#prime = {
#nvidiaBusId = "PCI:1:0:0";
#intelBusId = "PCI:0:2:0";
#offload = {
#enable = true;
#enableOffloadCmd = true;
#};
#};
#};
#services.xserver.videoDrivers = ["nvidia"];
 services.tlp.enable = true;
 #  Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.username = {
    isNormalUser = true;
    description = "Full name goes here, e.g. Bob Smith";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };
#users.extraUsers.username = {
#subUidRanges = [{ startUid = 100000; count = 65536; }];
#subGidRanges = [{ startGid = 100000; count = 65536; }];
#};
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

#packageOverrides = pkgs: with pkgs; {
#pidgin-with-plugins = pkgs.pidgin.override {
#plugins = [ purple-discord purple-plugin-pack];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
orca
speechd
pcmanfm
libcanberra-gtk3
unzip
unrar
p7zip
git
pulseaudio
libnotify
file
firefox
distrobox
(pidgin.override { plugins = [ purple-discord purple-plugin-pack ]; })
appimage-run
podman
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
#services.locate.enable = true;
#services.mullvad-vpn.enable = true;
#services.ollama.enable = true;
#services.brltty.enable = true;
#users.users.brltty.isNormalUser = true;
#programs.hyprland.enable = true;
programs.zsh.enable = true;
users.defaultUserShell = pkgs.zsh;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}


