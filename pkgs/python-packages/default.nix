{
  callPackage,
  python3
}:
{
  open3d-cpu = callPackage ./open3d/open3d-cpu.nix {
    inherit (python3.pkgs) buildPythonPackage;
  };
}
