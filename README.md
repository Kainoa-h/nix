# nix config

My personal Nix flake, using Home Manager to manage a NixOS desktop, macOS laptop, and NixOS-WSL environment.

| Host | Platform |
| --- | --- |
| `nix-muffin` | NixOS desktop |
| `macbook` | macOS with nix-darwin |
| `wsl-host` | NixOS-WSL |

## Structure

- `hosts/` contains the host-specific system and Home Manager configurations.
- `modules/` contains shared system and home modules.
- `packages/neovim/` contains the standalone Neovim package.
- Other folders are respective app specific configurations

## Standalone Neovim Derivation

The Neovim configuration is packaged independently with [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules) and can be run without using the rest of this config:

```sh
nix run github:Kainoa-h/nix#nvim
```
