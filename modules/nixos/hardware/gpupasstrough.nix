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
      #"nvidia-drm.fbdev=1" 
  ];

  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];

}
