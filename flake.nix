{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
        url = "github:ghostty-org/ghostty";
      };

    yazi-relative-motions = {
      url = "github:dedukun/relative-motions.yazi";
      flake = false;
    };
    yazi-starship = {
      url = "github:Rolv-Apneseth/starship.yazi";
      flake = false;
    };

    elephant.url = "github:abenz1267/elephant";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    awww.url = "git+https://codeberg.org/LGFae/awww";

    llm-agents.url = "github:numtide/llm-agents.nix";

    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugins-lze = {
      url = "github:BirdeeHub/lze";
      flake = false;
    };

    plugins-lzextras = {
      url = "github:BirdeeHub/lzextras";
      flake = false;
    };

    plugins-vague-nvim = {
      url = "github:vague-theme/vague.nvim";
      flake = false;
    };

   nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

  };

  outputs = { self, nixpkgs, nix-darwin, nixos-wsl, wrappers, ... }@inputs:
  let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    neovimModule = nixpkgs.lib.modules.importApply ./packages/neovim/module.nix inputs;
    neovimWrapper = wrappers.lib.evalModule neovimModule;
  in {
    packages = forAllSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.permittedInsecurePackages = [
            "pnpm-10.34.0"
          ];
        };
      in {
        nvim = neovimWrapper.config.wrap { inherit pkgs; };
      });

    apps = forAllSystems (system: {
      nvim = {
        type = "app";
        program = "${self.packages.${system}.nvim}/bin/nvim";
      };
    });

    nixosConfigurations = {
      # Main desktop
      nix-muffin = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/nix-muffin ];
      };

      wsl-host = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/wsl-host
        ];
      };

      # Example: Future laptop configuration
      # my-laptop = nixpkgs.lib.nixosSystem {
      #   specialArgs = { inherit inputs; };
      #   modules = [ ./hosts/my-laptop ];
      # };
    };

    darwinConfigurations = {
      # MacBook
      macbook = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/macbook
          inputs.home-manager.darwinModules.default
        ];
      };
    };
  };
}
