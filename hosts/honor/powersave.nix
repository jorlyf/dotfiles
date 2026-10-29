{
  ...
}:
{
  # TODO: intel-lpmd добавить, когда появится.

  services.tlp = {
    enable = true;

    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Жесткие лимиты ломают логику Intel HWP.
      # Контроллер процессора сам отлично прижмет частоты, если EPP выставлен в balance_power.
      # CPU_MIN_PERF_ON_AC = 0;
      # CPU_MAX_PERF_ON_AC = 100;
      # CPU_MIN_PERF_ON_BAT = 0;
      # CPU_MAX_PERF_ON_BAT = 10;

      # Управление питанием графики Intel и шины памяти (Uncore)
      # Это заставит контроллер памяти и SoC-плитку сбрасывать частоты при проигрывании видео
      INTEL_GPU_MIN_FREQ_ON_AC = 0;
      INTEL_GPU_MIN_FREQ_ON_BAT = 0;
      INTEL_GPU_BOOST_ON_AC = 1;
      INTEL_GPU_BOOST_ON_BAT = 0;
      INTEL_GPU_BOOST_FREQ_ON_AC = 1;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 0;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      AHCI_RUNTIME_PM_ON_AC = "auto";

      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";

      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "min_power";

      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      WIRELESS_POWER_SAVING_ON_AC = "off";
      WIRELESS_POWER_SAVING_ON_BAT = "on";

      USB_AUTOSUSPEND = 1;
    };
  };
}
