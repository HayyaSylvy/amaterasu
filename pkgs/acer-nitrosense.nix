 { stdenv, lib
, fetchurl
, alsaLib
, openssl
, zlib
, pulseaudio
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "Linux-NitroSense";
  version = "0.4.2";

  src = fetchurl {
    url = "https://github.com/Packss/Linux-NitroSense/releases/download/v${version}/nitrosense";
    hash = "sha256-";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    alsaLib
    openssl
    zlib
    libxcb
    python313Packages.altgraph
    python313Packages.packaging
    python313Packages.pip
    python313Packages.py-dmidecode
    python313Packages.pyinstaller
    python313Packages.pyinstaller-hooks-contrib
    python313Packages.pyqt6
    python313Packages.pyqt6-charts
    python313Packages.pyqt6-sip
    python313Packages.setuptools
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D nitrosense $out/bin/nitrosense
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/Packss/Linux-NitroSense";
    description = "Clone of Acer's NitroSense application for Linux.";
    platforms = platforms.linux;
  };
}

