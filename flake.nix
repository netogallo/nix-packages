{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ...}:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
	"x86_64-linux"
      ];
      perSystem = { self', pkgs, system, ... }:
	let
	  netogallo-pkgs = import ./default.nix { nixpkgs = pkgs; };
	in
	{
	  packages = netogallo-pkgs;
	};
    };
}
