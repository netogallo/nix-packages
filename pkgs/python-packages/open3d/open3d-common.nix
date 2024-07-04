{
  lib,
  buildPythonPackage,
  pkgs,
  python3,
  embree3
}:

buildPythonPackage {
  pname = "open3d-cpu";
  version = "0.18.0";
  pyproject = false;
  src = fetchTarball { url = "https://github.com/isl-org/Open3D/archive/refs/tags/v0.18.0.tar.gz"; sha256 = "1qpjxscnkw1mqgpjb6dkfdvwlr6l8gzj7x9nz133hlynhxcs9k2l"; };
  patches = [
    ./0001-Patch-to-make-v0.18.0-compile-with-nix-24.05.patch 
  ];
  build-system = with pkgs; [
    cmake
    git
    openssl
    pkg-config
    python3.pkgs.pypaInstallHook
  ];
  dependencies = with python3.pkgs; [
    configargparse
    numpy
    dash
    nbformat
    pybind11
    python-lzf
    setuptools
    werkzeug
    wheel
  ];
  buildInputs = with pkgs; with xorg; [
    libX11
    libXrandr
    libXinerama
    vulkan-headers
    libXcursor
    libcxx
    curl
    assimp
    eigen
    fmt
    glew
    glfw
    imgui
    libjpeg
    jsoncpp
    msgpack-cxx
    nanoflann
    libpng
    qhull
    librealsense
    tinyobjloader
    vtk
    openssl_3_0
    boost
    blas
    lapack
    tbb
    minizip
    fmt
    zeromq
    cppzmq
    embree3
  ];
  preConfigure = ''
    desktopOverrideFlag="-DOVERRIDE_DESKTOP_INSTALL_DIR=$out/share"
    cxxOverridesFlag="-Wno-error=array-bounds -fpermissive -Wno-error=changes-meaning -Wno-error=unused-variable -Wno-error=pessimizing-move -Wno-error=unused-function"
    cmakeFlagsArray+=($desktopOverrideFlag -DCMAKE_CXX_FLAGS="$cxxOverridesFlag")
  '';
  makeFlags = [ "pip-package" ];
  cmakeFlags = [ 
    "-DOPEN3D_USE_ONEAPI_PACKAGES=OFF"
    "-DUSE_BLAS=ON" 
    "-DBUNDLE_OPEN3D_ML=OFF"
    "-DBUILD_JUPYTER_EXTENSION=OFF"
    "-DBUILD_AZURE_KINECT=OFF"
    "-DBUILD_PYTORCH_OPS=OFF"
    "-DBUILD_CUDA_MODULE=OFF"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_UNIT_TESTS=OFF"
    "-DBUILD_BENCHMARKS=OFF"
    "-DBUILD_WEBRTC=OFF"
    "-DBUILD_SHARED_LIBS=OFF"
    "-DUSE_SYSTEM_BLAS=ON"
    "-DUSE_SYSTEM_ASSIMP=ON"
    "-DUSE_SYSTEM_CURL=ON"
    "-DUSE_SYSTEM_CUTLASS=ON"
    "-DUSE_SYSTEM_EIGEN3=ON"
    "-DUSE_SYSTEM_FILAMENT=OFF"
    "-DUSE_SYSTEM_FMT=ON"
    "-DUSE_SYSTEM_GLEW=ON"
    "-DUSE_SYSTEM_GLFW=ON"
    "-DUSE_SYSTEM_IMGUI=ON"
    "-DUSE_SYSTEM_JPEG=ON"
    "-DUSE_SYSTEM_JSONCPP=ON"
    "-DUSE_SYSTEM_LIBLZF=OFF"
    "-DUSE_SYSTEM_MSGPACK=ON"
    "-DUSE_SYSTEM_NANOFLANN=ON"
    "-DUSE_SYSTEM_OPENSSL=OFF"
    "-DUSE_SYSTEM_PNG=ON"
    "-DUSE_SYSTEM_PYBIND11=ON"
    "-DUSE_SYSTEM_QHULLCPP=ON"
    "-DUSE_SYSTEM_STDGPU=ON"
    "-DUSE_SYSTEM_TBB=ON"
    "-DUSE_SYSTEM_TINYOBJLOADER=ON"
    "-DUSE_SYSTEM_VTK=ON"
    "-DUSE_SYSTEM_ZEROMQ=ON"
    "-DWITH_MINIZIP=TRUE"
    "-DWITH_IPPICV=OFF"
    "-DWITH_UV_ATLAS=OFF"
    "-DBUILD_ISPC_MODULE=OFF"
    "-DUSE_SYSTEM_TBB=ON"
    "-DUSE_SYSTEM_FMT=ON"
    "-DUSE_SYSTEM_EMBREE=ON"
  ];
  preInstall = ''
    mkdir -p dist/
    wheel_directory="$PWD/lib/python_package/pip_package/"
    wheel_file="$wheel_directory/open3d*.whl"
    cp -v $wheel_file dist/
  '';
}

