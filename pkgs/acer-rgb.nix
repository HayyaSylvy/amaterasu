{ stdenv, lib, fetchFromGitHub, kernel, kmod }:
stdenv.mkDerivation rec {
  name = "acer-predator-turbo-and-rgb-keyboard-linux-module-${version}-${kernel.modDirVersion}";
  version = "main";

  src = fetchFromGitHub {
    owner = "JafarAkhondali";
    repo = "acer-predator-turbo-and-rgb-keyboard-linux-module";
    rev = "${version}";
    sha256 = "sha256-aBdxF3GJX8jJjwBvHxHnzNNO/r5GiVpAbkfTsj5jD1Q=";
  };

   setSourceRoot = ''
    export sourceRoot=$(pwd)/source
  '';
  nativeBuildInputs = kernel.moduleBuildDependencies;
  makeFlags = (lib.filter (x: x != "--eval=undefine modules") kernel.makeFlags) ++ [
    "-C"
    "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(sourceRoot)"
    "KBUILD_OUTPUT=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];
  buildFlags = [ "modules" ];
  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ]; 


  meta = with lib; {
    description = "Improved Linux driver for Acer RGB Keyboards ";
    homepage = "https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
