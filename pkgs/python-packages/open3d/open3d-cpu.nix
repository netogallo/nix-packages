{
  callPackage,
  buildPythonPackage
}:
callPackage ./open3d-common.nix { inherit buildPythonPackage; }
