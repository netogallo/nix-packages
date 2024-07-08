{
  nixpkgs ? import (fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/24.05.tar.gz"; }) {}
}:
let
  inherit (nixpkgs) callPackage; 
  netogallo-pkgs = rec {
    inherit netogallo-pkgs nixpkgs;
    callPackage = nixpkgs.newScope netogallo-pkgs;
    embree3 = netogallo-pkgs.callPackage ./pkgs/embree/embree3.nix { };
    oneDPL-20190522 = netogallo-pkgs.callPackage ./pkgs/oneDPL/oneDPL.nix { };
    poissonrecon = netogallo-pkgs.callPackage ./pkgs/poissonrecon/poissonrecon.nix { };
    python-packages = netogallo-pkgs.callPackage ./pkgs/python-packages/default.nix { };
  };
in
  netogallo-pkgs
