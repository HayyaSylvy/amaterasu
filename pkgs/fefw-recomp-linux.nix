# fefw-recomp-linux.nix
#
# Packages the Linux release of https://github.com/aidankinzett/fefw-recomp-linux
# (Fire Emblem: Fortune's Weave static recompilation; bring your own dump).
#
# Why this is not a plain "unpack and install":
#   * The release is a tarball of foreign, prebuilt binaries (Tauri AppImage
#     launcher, relocatable CPython, Zig, a self-contained .NET shader
#     translator). None of them know about /nix/store, so they run inside an
#     FHS environment (buildFHSEnv) instead of being patchelf'd one by one.
#   * The launcher's "Set up" step builds the game INTO the launcher's own
#     folder (game/, work/, save/, ...). The Nix store is read-only, so the
#     wrapper syncs the package into ~/.local/share/fefw-recomp on first run
#     (and again whenever the Nix package changes) and runs it from there.
#   * AppImages need FUSE; NixOS can't rely on it, so the AppImage is run in
#     extract-and-run mode.
#   * The game itself still runs as fefw.exe through umu-run (Proton), which
#     the launcher calls from PATH, so umu-launcher is put in the environment.
#
# Usage:
#   environment.systemPackages = [ (pkgs.callPackage ./fefw-recomp-linux.nix { }) ];
#
# UNVERIFIED (see notes in the chat reply): `assetName` and `hash` below.
{
  lib,
  stdenv,
  fetchurl,
  buildFHSEnv,
  writeShellScript,
  makeDesktopItem,
  rsync,
  git,
  cacert,
  gtk3,
  glib-networking,
  gsettings-desktop-schemas,
  shared-mime-info,
  adwaita-icon-theme,

  # Release coordinates. Tags in this repo are commit hashes: every commit on
  # master gets a release. 1aca6af was the latest on 2026-11-10.
  releaseTag ? "1aca6af",
  # Documented pattern is fefw-recomp-<version>-linux-x64.tar.gz, where
  # <version> is the upstream version ("Runtime from upstream v0.1.6").
  # Check the real name on the release page and adjust if it differs.
  assetName ? "fefw-recomp-0.1.6-linux-x64.tar.gz",
  # Replace after the first build prints the real one (or use
  #   nix store prefetch-file --json <url>   ).
  hash ? lib.fakeHash,
}:

let
  version = "0.1.6-${releaseTag}";

  # The unmodified release contents, in the store (read-only).
  tree = stdenv.mkDerivation {
    pname = "fefw-recomp-linux-tree";
    inherit version;

    src = fetchurl {
      url = "https://github.com/aidankinzett/fefw-recomp-linux/releases/download/${releaseTag}/${assetName}";
      inherit hash;
    };

    # Don't guess whether the tarball has one top-level directory or several.
    sourceRoot = ".";

    dontConfigure = true;
    dontBuild = true;
    # Never strip/patchelf: these are foreign binaries that run in the FHS env.
    dontFixup = true;

    installPhase = ''
      runHook preInstall

      launcher="$(find . -name fefw-launcher.AppImage -print -quit)"
      if [ -z "$launcher" ]; then
        echo "fefw-launcher.AppImage not found in ${assetName}" >&2
        exit 1
      fi
      root="$(dirname "$launcher")"

      mkdir -p $out/share/fefw-recomp
      cp -a "$root"/. $out/share/fefw-recomp/

      runHook postInstall
    '';
  };

  # Runs inside the FHS environment.
  start = writeShellScript "fefw-recomp-start" ''
    set -euo pipefail

    src="${tree}/share/fefw-recomp"
    data="''${FEFW_HOME:-''${XDG_DATA_HOME:-$HOME/.local/share}/fefw-recomp}"

    mkdir -p "$data"

    # (Re)populate the writable copy when the Nix package changed.
    # Your save/, mods/, game/, work/ and upscalers/ are never touched.
    if [ "$(cat "$data/.nix-source" 2>/dev/null || true)" != "$src" ]; then
      echo "fefw-recomp: installing package into $data ..." >&2
      ${rsync}/bin/rsync -rlt --perms --no-owner --no-group --chmod=u+w \
        --ignore-times \
        --exclude=/save --exclude=/mods --exclude=/game --exclude=/work \
        --exclude=/upscalers \
        "$src"/ "$data"/
      printf '%s' "$src" > "$data/.nix-source"
      echo "fefw-recomp: package updated; run Set up in the launcher again." >&2
    fi

    cd "$data"

    # AppImage without FUSE.
    export APPIMAGE_EXTRACT_AND_RUN=1
    # Bundled WebKit often renders a blank window on NixOS (esp. NVIDIA).
    export WEBKIT_DISABLE_DMABUF_RENDERER="''${WEBKIT_DISABLE_DMABUF_RENDERER:-1}"
    export NO_AT_BRIDGE=1

    # Setup downloads (pip, git clone of the shader translator sources).
    export SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt"
    export GIT_SSL_CAINFO="$SSL_CERT_FILE"
    export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"
    export CURL_CA_BUNDLE="$SSL_CERT_FILE"

    # GTK file chooser etc. (without schemas GTK aborts on NixOS).
    export XDG_DATA_DIRS="''${XDG_DATA_DIRS:+$XDG_DATA_DIRS:}${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:${shared-mime-info}/share:${adwaita-icon-theme}/share"
    export GIO_EXTRA_MODULES="${glib-networking}/lib/gio/modules''${GIO_EXTRA_MODULES:+:$GIO_EXTRA_MODULES}"

    # GL / Vulkan drivers from the host NixOS system.
    export LD_LIBRARY_PATH="''${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}/run/opengl-driver/lib:/run/opengl-driver-32/lib"

    exec "$data/fefw-launcher.AppImage" "$@"
  '';

  desktopItem = makeDesktopItem {
    name = "fefw-recomp";
    desktopName = "Fortune's Weave Recomp";
    comment = "Launcher for the Fire Emblem: Fortune's Weave recompilation (bring your own dump)";
    exec = "fefw-recomp";
    terminal = false;
    categories = [ "Game" ];
  };
in
buildFHSEnv {
  pname = "fefw-recomp-linux";
  inherit version;
  executableName = "fefw-recomp";

  runScript = start;

  targetPkgs =
    pkgs:
    let
      # nixpkgs moved xorg.libX11 -> libx11 etc.; accept either spelling.
      x = new: old: pkgs.${new} or pkgs.xorg.${old};
    in
    with pkgs;
    [
      # Tools the launcher / Setup shell out to
      git
      curl
      rsync
      unzip
      zip
      xz
      zstd
      file
      which
      procps
      cacert
      xdg-utils # "Open full log", "Open mods folder"
      umu-launcher # `umu-run`, the default Runner for Play

      # Runtime libs for the AppImage launcher (it bundles most of them;
      # these are the safety net), Zig, CPython and the .NET translator
      stdenv.cc.cc.lib
      zlib
      openssl
      icu
      krb5
      glib
      glib-networking
      gtk3
      gdk-pixbuf
      cairo
      pango
      atk
      harfbuzz
      librsvg
      libsoup_3
      webkitgtk_4_1
      libayatana-appindicator
      xdotool
      dbus
      fontconfig
      freetype
      dejavu_fonts
      shared-mime-info
      gsettings-desktop-schemas
      adwaita-icon-theme

      # Graphics / input / audio
      mesa
      libGL
      libglvnd
      vulkan-loader
      libdrm
      libxkbcommon
      wayland
      alsa-lib
      libpulseaudio
      (x "libx11" "libX11")
      (x "libxcursor" "libXcursor")
      (x "libxrandr" "libXrandr")
      (x "libxi" "libXi")
      (x "libxext" "libXext")
      (x "libxrender" "libXrender")
      (x "libxfixes" "libXfixes")
      (x "libxcomposite" "libXcomposite")
      (x "libxdamage" "libXdamage")
      (x "libxtst" "libXtst")
      (x "libxcb" "libxcb")
    ]
    ++ lib.optional (pkgs ? libgbm) pkgs.libgbm;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    ln -s ${desktopItem}/share/applications/*.desktop $out/share/applications/
  '';

  passthru = { inherit tree; };

  meta = {
    description = "Launcher and native Linux package for the Fire Emblem: Fortune's Weave recompilation (bring your own dump)";
    homepage = "https://github.com/aidankinzett/fefw-recomp-linux";
    license = lib.licenses.gpl3Only;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "fefw-recomp";
  };
}
