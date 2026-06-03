{ stdenv, lib, pkgs
, fetchurl
, fetchzip
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "Endcord";
  version = "1.4.2";

  src = fetchzip {
    url = "https://github.com/sparklost/endcord/releases/download/1.4.2/endcord-1.4.2-linux.tar.gz";
    hash = "sha256:25c793c87e1b3f43d75f9bd4a6c45801830d50a9093754dd25f104550a64a927";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = with pkgs; [];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D $src $out/bin/endcord
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/sparklost/endcord";
    description = "Discord TUI for Linux.";
    platforms = platforms.linux;
  };
}
