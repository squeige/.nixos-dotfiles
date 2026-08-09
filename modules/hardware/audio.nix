{ pkgs, ... }:

{
  # Disable legacy ALSA/PulseAudio services
  services.pulseaudio.enable = false;

  # Enable RealtimeKit for high-priority audio processing
  security.rtkit.enable = true;

  # Enable PipeWire service
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Enable WirePlumber state restoration
    wireplumber.extraConfig = {
      "10-restore-state" = {
        "wireplumber.settings" = {
          "state.restore-props" = true;
          "state.restore-target" = true;
        };
      };
    };
  };

  # Useful audio utilities
  environment.systemPackages = with pkgs; [
    pavucontrol # Graphical volume control mixer
    pamixer     # CLI volume control
    wireplumber # PipeWire session manager tool
  ];
}
