{
  description = "My Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Use a specific branch like nixos-25.05 or nixos-unstable

    home-manager = {
      url = "github:nix-community/home-manager"; # Specify the desired release or branch
      inputs.nixpkgs.follows = "nixpkgs"; # Ensure home-manager uses the same nixpkgs version
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    homeConfigurations."james" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs;

      # Import your home.nix configuration file
      modules = [
        ./home.nix
      ];
    };
  };
}
