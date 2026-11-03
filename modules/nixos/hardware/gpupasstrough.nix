{ lib, pkgs, ...}:
{
  boot.kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "acpi_backlight=native"
      "acpi_osi"
      "amd_iommu=on"
      "sys.use_memfd=true"
      #"rd.systemd.show_status=auto"
      "clearcpuid=514"
      "vfio-pci.ids=10de:24a0,10de:228b"
      "kvm_amd_nested=1"
      "kvmfr.static_size_mb=64"
      #"nvidia-drm.fbdev=1" 
  ];

  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';
  services.udev.packages = lib.singleton (pkgs.writeTextFile
    { 
      name = "kvmfr";
      text = ''
        SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660", TAG+="uaccess"
      '';
      destination = "/etc/udev/rules.d/70-kvmfr.rules";
    }
  );
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];

}
