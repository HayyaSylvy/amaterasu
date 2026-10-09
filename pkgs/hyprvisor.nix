{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
  kmod,
}:

# Out-of-tree kernel module: build it against a specific kernel package, e.g.
#   config.boot.kernelPackages.callPackage ./package.nix { }
stdenv.mkDerivation (finalAttrs: {
  pname = "cpuid-fault-emulation";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "dnmodder";
    repo = "cpuid-fault-emulation";
    rev = "v${finalAttrs.version}";
    hash = "sha256-ZpYY5EC1GPyTFyuYq3uY3a6OXlMeHrj/N8rdkPaDFyQ=";
  };

  hardeningDisable = [
    "pic"
    "format"
  ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  # kernel.makeFlags also carries flags meant for building the kernel itself
  # (O=$(buildRoot), and "--eval=undefine modules", which gets word-split into
  # a bare "--eval=undefine" and fails with "empty variable name").
  # Out-of-tree modules must not receive them.
  kernelMakeFlags = lib.filter (
    flag: !(lib.hasPrefix "O=" flag) && !(lib.hasPrefix "--eval" flag)
  ) kernel.makeFlags;

  # The upstream Makefile hardcodes /lib/modules/$(KERNEL)/build and greps
  # that tree's .config at parse time, none of which exists in the sandbox.
  # Bypass it: kbuild prefers a file named Kbuild over Makefile, so write one
  # with the same object list and call the kernel build system directly.
  buildPhase = ''
    runHook preBuild

    cat > Kbuild <<'EOF'
    obj-m += cpuid_fault_emulation.o
    cpuid_fault_emulation-y := src/cpuid_fault_emulation.o src/capture_context.o src/run_vm.o
    ccflags-y += -I$(src)/inc
    asflags-y += -I$(src)/inc
    EOF

    make ${lib.escapeShellArgs finalAttrs.kernelMakeFlags} \
      -j"$NIX_BUILD_CORES" \
      -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M="$PWD" modules

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 cpuid_fault_emulation.ko \
      $out/lib/modules/${kernel.modDirVersion}/extra/cpuid_fault_emulation.ko

    # NixOS has no /usr/bin. Use the system profile, whose modprobe wrapper
    # knows where the module tree lives (needs kmod and gnugrep in
    # environment.systemPackages, which NixOS provides by default).
    mkdir -p $out/libexec/cpuid-fault-emulation
    substitute cpuid-fault-emulation-helper \
      $out/libexec/cpuid-fault-emulation/cpuid-fault-emulation-helper \
      --replace-fail 'export PATH="/usr/bin:/bin"' 'export PATH="/run/current-system/sw/bin"' \
      --replace-fail "/usr/bin/" ""
    chmod 755 $out/libexec/cpuid-fault-emulation/cpuid-fault-emulation-helper

    mkdir -p $out/lib/systemd/system
    substitute cpuid-fault-emulation.service \
      $out/lib/systemd/system/cpuid-fault-emulation.service \
      --replace-fail "/usr/lib/cpuid-fault-emulation/" "$out/libexec/cpuid-fault-emulation/"

    install -Dm644 10-cpuid-fault-emulation.rules \
      $out/share/polkit-1/rules.d/10-cpuid-fault-emulation.rules

    runHook postInstall
  '';

  meta = {
    description = "Kernel module emulating CPUID faulting on AMD Zen 1-3 via SVM";
    longDescription = ''
      Emulates architectural CPUID faulting on AMD processors that lack the
      hardware MSR (before Zen 4), as needed by some Windows games under
      Wine/Proton. It uses AMD SVM and therefore conflicts with KVM; the
      bundled systemd service unloads KVM before loading the module and
      restores it afterwards.
    '';
    homepage = "https://github.com/dnmodder/cpuid-fault-emulation";
    license = lib.licenses.gpl2Only;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
    broken = kernel.kernelOlder "5.4";
  };
})
