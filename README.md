# Squeige NixOS Dotfiles

Modular NixOS flake configuration managed with [home-manager](https://github.com/nix-community/home-manager). Hosts include my desktop, laptop, and a VM — all built from shared modules so system services and user apps stay reusable and consistent across machines.

## Hosts

| Host          | Hardware                         | Notable config                      |
|---------------|----------------------------------|-------------------------------------|
| `squeigedesk` | Desktop (AMD CPU + NVIDIA GPU)   | Niri + Ly, secure boot (lanzaboote) |
| `squeigeloq`  | Lenovo LOQ laptop (NVIDIA GPU)   | Power tuning, NVIDIA tweaks         |
| `vm01`        | Hyper-V VM                       | Minimal                              |

## Directory structure

```
.
├── flake.nix                  # Flake entry: inputs & nixosConfigurations
├── flake.lock
├── config
│   └── nvim                   # Neovim config (linked into home-manager)
│       ├── init.lua
│       ├── lazy-lock.json
│       └── lua
│           ├── config         # Editor base: options, keymaps, clipboard
│           └── plugins        # LSP, treesitter, telescope, colorscheme, ...
├── hosts                      # Per-machine configuration
│   ├── squeigedesk
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── squeigeloq
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── hardware           # Host-specific hardware modules
│   │       ├── default.nix
│   │       ├── nvidialoq.nix
│   │       └── power.nix
│   └── vm01
│       ├── configuration.nix
│       └── hardware-configuration.nix
└── modules                    # Shared, reusable NixOS + home-manager modules
    ├── desktops               # DEs/WMs, switchable via mySystem.desktops.<name>.enable
    │   ├── default.nix        # Imports all desktops
    │   ├── display_ly.nix     # Ly display/login manager
    │   ├── niri.nix           # Niri compositor
    │   ├── qtile.nix          # Qtile
    │   └── x11.nix            # X11 / display server
    ├── hardware               # Shared hardware support
    │   ├── audio.nix
    │   ├── lanzaboote.nix     # Secure boot
    │   └── nvidia.nix
    ├── home                   # Home-manager (user-level apps & config)
    │   └── default.nix
    └── system                 # System services & users
        ├── bluetooth.nix
        ├── incus.nix
        ├── luigi.nix          # Primary user (gated behind mySystem.users.luigi.enable)
        └── openssh.nix
```

## Policy

- **User apps** (editors, terminals, dev tools): `modules/home/`
- **System services** (audio, bluetooth, boot): `modules/{hardware,system}/`, each module owns its own required packages
- **Host configs** keep only rescue tools (`vim`, `wget`, `curl`) and host wiring
- **Feature toggles**: optional features are gated behind `mySystem.<category>.<name>.enable`
  (e.g. `mySystem.desktops.niri.enable`, `mySystem.users.luigi.enable`)

## Usage

```bash
# Rebuild a host
sudo nixos-rebuild switch --flake .#squeigedesk
sudo nixos-rebuild switch --flake .#squeigeloq
sudo nixos-rebuild switch --flake .#vm01

# Update flake inputs
nix flake update
```
