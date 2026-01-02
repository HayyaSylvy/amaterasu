{ stdenv, lib, pkgs
, fetchurl
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "Nitrosense";
  version = "0.4.2";

  src = fetchurl {
    url = "https://github.com/Packss/Linux-NitroSense/releases/download/v0.4.2/nitrosense";
    hash = "sha256-xE/GSSUAlh55aWbYc+MEQRIcfQ/aBXtW4lIaTCZijJ0=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  dontUnpack = true;

  baseInputs = [];

  buildInputs = with pkgs; [
  libz
  ell
  libc
  libpthread-stubs
  ];

  sourceRoot = ".";

  installPhase = ''
    install -m755 -D $src $out/bin/nitrosense
    chmod a+x $out/bin/nitrosense
    patchelf $out/bin/nitrosense
  '';

  meta = with lib; {
    homepage = "https://studio-link.com";
    description = "Nitrosense for linux.";
    platforms = platforms.linux;
  };
}
