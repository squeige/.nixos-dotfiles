# Welcome to my modular Nixos Setup

## Structure (as of 08/11)
```
.
├── flake.lock
├── flake.nix
├── hosts
│   ├── squeigeloq              # Lenovo LOQ laptop
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── hardware            # Host-specific hardware modules
│   │       ├── default.nix
│   │       ├── nvidialoq.nix
│   │       └── power.nix
│   └── vm01                    # Hyper-V VM
│       └── configuration.nix
├── modules
│   ├── desktops                # Desktop environments / WMs (switchable via mySystem.desktops)
│   │   ├── default.nix
│   │   ├── display_ly.nix
│   │   ├── niri.nix
│   │   ├── qtile.nix
│   │   └── x11.nix
│   ├── hardware                # Shared hardware modules
│   │   ├── audio.nix
│   │   └── lanzaboote.nix
│   ├── home                    # Home Manager (user-level apps & config)
│   │   └── default.nix
│   └── system                  # System services & users
│       ├── bluetooth.nix
│       ├── incus.nix
│       ├── luigi.nix
│       └── openssh.nix
└── config
    └── nvim
```

## Policy
- **User apps** (editors, terminals, dev tools): `modules/home/`
- **System services** (audio, bluetooth, boot): `modules/{hardware,system}/`, each module owns its own required packages
- **Host configs** keep only rescue tools (`vim`, `wget`, `curl`) and host wiring
- **Feature toggles**: optional features are gated behind `mySystem.<category>.<name>.enable`
  (e.g. `mySystem.desktops.niri.enable`, `mySystem.users.luigi.enable`)
