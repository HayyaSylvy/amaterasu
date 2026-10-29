{ stdenv, lib, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation rec {
  pname = "acer-predator-turbo-and-rgb-keyboard-linux-module";
  version = "main";
  name = "${pname}-${version}-${kernel.modDirVersion}";

  src = fetchFromGitHub {
    owner = "JafarAkhondali";
    repo = "acer-predator-turbo-and-rgb-keyboard-linux-module";
    rev = version;
    sha256 = "sha256-XyLwSNB/dvykYGmB0C0vV2sJaGX09dQ9chygVtly1lM=";
  };

  hardeningDisable = [ "pic" "format" ];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags =
    (lib.filter
      (x: !(lib.hasPrefix "--eval=undefine" x) && !(lib.hasPrefix "O=" x))
      kernel.makeFlags)
    ++ [
      "-C"
      "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
      "M=$(PWD)"
    ];

  buildFlags = [ "modules" ];
  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ];

  meta = with lib; {
    description = "Improved Linux driver for Acer RGB Keyboards";
    homepage = "https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
