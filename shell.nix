{
  netogallo-pkgs ? import ./default.nix {},
  python-packages ? ""
}:
let
  pkgs = netogallo-pkgs.nixpkgs.pkgs;
  python-packages-list = map (name: netogallo-pkgs.python-packages.${name}) (pkgs.lib.strings.split "," python-packages);
in
pkgs.mkShell {
  inputsFrom = [];
  packages = [
    (pkgs.python3.withPackages (ps: python-packages-list))
    pkgs.python3.pkgs.pip
  ];
}

