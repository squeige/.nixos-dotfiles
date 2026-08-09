# Welcome to my modular Nixos Setup


## Currently this is my structure as of 08/09
```
[luigi@squeigeloq:~/.nixos-dotfiles]$ tree
.
├── flake.lock
├── flake.nix
├── home.nix
├── hosts
│   └── squeigeloq
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules
│   ├── hardware
│   │   ├── audio.nix
│   │   ├── lanzaboote.nix
│   │   ├── nvidialoq.nix
│   │   └── squeigeloq.nix
│   └── system
│       └── incus.nix
└── README.md

6 directories, 11 files
```
