# AGENTS.md

NixOS flake managing 3 hosts (`squeigedesk`, `squeigeloq`, `vm01`) with home-manager as a NixOS module. `README.md` has the full host table and directory map — it is accurate; read it before restructuring anything.

## Commands

- Verify a change without touching the live system: `nixos-rebuild build --flake .#<host>` (no sudo needed).
- Apply to the live system: `sudo nixos-rebuild switch --flake .#<host>` — only run when the user explicitly asks. This repo configures the machine you are running on; `switch` mutates it immediately.
- Update inputs: `nix flake update`.
- There is no formatter, linter, test suite, or CI configured. The build is the only check — don't invent `nixfmt`/`statix` steps.

## Conventions

- Optional features follow a toggle pattern: declare `options.mySystem.<category>.<name>.enable = lib.mkEnableOption ...` and gate everything behind `lib.mkIf cfg.enable` (see `modules/desktops/niri.nix`, `modules/system/luigi.nix`). Follow this for new optional modules.
- Placement policy (from README, enforced in practice): user apps → `modules/home/` (home-manager), system services → `modules/{hardware,system}/`, host configs keep only rescue tools (`vim`/`wget`/`curl`) + wiring. Don't add user apps to host `environment.systemPackages`.
- Host-specific hardware quirks go in `hosts/<host>/hardware/` (see `squeigeloq`); `modules/hardware/` is for shared support only.
- home-manager runs inline as a NixOS module in each host config — there is no standalone `home-manager switch`. Changes under `modules/home/` or `config/nvim/` only take effect after `nixos-rebuild switch` (files are copied into the nix store, not live-symlinked).
- Package sources in home modules: unstable via `inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.<pkg>`, flake inputs via `inputs.<name>.packages.${pkgs.stdenv.hostPlatform.system}.default` (see `modules/home/default.nix`).
- Flake-input NixOS modules (niri, lanzaboote, home-manager) are imported inside modules via `inputs.*`; `specialArgs`/`extraSpecialArgs` already pass `inputs` everywhere — no wiring needed when adding modules.

## Gotchas

- Physical hosts use lanzaboote secure boot: `boot.loader.systemd-boot.enable` is force-disabled by `modules/hardware/lanzaboote.nix`. Leave the commented-out bootloader lines in those host configs commented. `vm01` is the exception (plain systemd-boot, Hyper-V guest).
- Keep `nixpkgs` and `home-manager` inputs on matching release branches (currently `26.05`); home-manager follows nixpkgs.
- When adding a host: the `nixosConfigurations` attribute name must match its `networking.hostName`, and pass `specialArgs = { inherit inputs; }`.
- All hosts set `nixpkgs.config.allowUnfree = true` (NVIDIA); keep it when creating new hosts.
