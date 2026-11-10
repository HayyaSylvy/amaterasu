# Packaged from the upstream x86_64 Linux tar.gz release.
{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, copyDesktopItems
, makeDesktopItem
, qt6
, ffmpeg_6
, openssl
, libusb1
, brotli
, lz4
, zlib
, libglvnd
, vulkan-loader
, libxkbcommon
, patchelf
, sndio
, alsa-lib
, libjack2
, pipewire
, libpulseaudio
, libx11
, libxext
, libxcursor
, libxi
, libxfixes
, libxrandr
, libxscrnsaver
, libxtst
, libdrm
, libdecor
, wayland
, dbus
, systemdLibs
, pgo ? true   # set to false for the non-PGO tarball
}:

stdenv.mkDerivation rec {
  pname = "eglantine";
  build = "212";
  version = "build-${build}${lib.optionalString pgo "-pgo"}";
  src = fetchurl {
    url = "https://github.com/Djihads80/Eglantine/releases/download/build-${build}/eglantine-linux-x86_64${lib.optionalString pgo "-pgo"}.tar.gz";
    hash = "sha256-cX/YeVGNxB5CGC0dyzWvXQFAlV6c4dIy+hVnLiLqhAE=";
  };
  sourceRoot = ".";
  nativeBuildInputs = [
    autoPatchelfHook
    copyDesktopItems
    patchelf
    qt6.wrapQtAppsHook
  ];
  buildInputs = [
    qt6.qtbase
    qt6.qtcharts
    qt6.qtsvg
    qt6.qtwayland 
    ffmpeg_6
    openssl
    libusb1
    brotli
    lz4
    zlib
    libglvnd         
    stdenv.cc.cc.lib
    sndio
    alsa-lib
    libjack2
    pipewire
    libpulseaudio
    libx11
    libxext
    libxcursor
    libxi
    libxfixes
    libxrandr
    libxscrnsaver
    libxtst
    libdrm
    libdecor
    wayland
    dbus
    systemdLibs
  ];
  runtimeDependencies = [ vulkan-loader libxkbcommon ];
  autoPatchelfIgnoreMissingDeps = [ "libsteam_api.so" "libGLES_CM.so.1" ];
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    runHook preInstall

    for bin in eglantine eden-cli; do
      path="$(find . -type f -name "$bin" | head -n1)"
      if [ -z "$path" ]; then
        echo "error: $bin not found in tarball; contents:" >&2
        find . -type f >&2
        exit 1
      fi
      install -Dm755 "$path" "$out/bin/$bin"
    done

    find . -type f \( -name '*.so' -o -name '*.so.*' \) \
      -exec install -Dm755 -t "$out/lib" {} +

    runHook postInstall
  '';
  preFixup = ''
    addAutoPatchelfSearchPath "$out/lib"

    for bin in eglantine eden-cli; do
      for lib in libsteam_api.so libGLES_CM.so.1; do
        if [ ! -e "$out/lib/$lib" ]; then
          echo "note: $lib not shipped; removing it from $bin"
          patchelf --remove-needed "$lib" "$out/bin/$bin"
        fi
      done
    done
    qtWrapperArgs+=(
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ vulkan-loader libglvnd libxkbcommon ]}:/run/opengl-driver/lib
    )
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "eglantine";
      desktopName = "Eglantine";
      genericName = "Switch Emulator";
      comment = "Experimental Nintendo Switch / Switch 2 emulator";
      exec = "eglantine %f";
      terminal = false;
      categories = [ "Game" "Emulator" "Qt" ];
      keywords = [ "Nintendo" "Switch" ];
      mimeTypes = [
        "application/x-nx-nro"
        "application/x-nx-nso"
        "application/x-nx-nsp"
        "application/x-nx-xci"
      ];
      startupWMClass = "eglantine";
    })
  ];

  meta = {
    description = "Experimental Nintendo Switch / Switch 2 emulator (Yuzu/Eden derivative)";
    homepage = "https://github.com/Djihads80/Eglantine";
    license = lib.licenses.gpl3Plus;
    platforms = [ "x86_64-linux" ];
    mainProgram = "eglantine";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
