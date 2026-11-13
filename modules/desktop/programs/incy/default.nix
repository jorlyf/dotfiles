{
  pkgs,
  ...
}:
let
  version = "3.9.0";

  runtimeLibs = [
    pkgs.alsa-lib
    pkgs.fontconfig
    pkgs.freetype
    pkgs.glib
    pkgs.gtk3
    pkgs.iptables
    pkgs.libayatana-appindicator
    pkgs.libglvnd
    pkgs.libnotify
    pkgs.mesa
    pkgs.nspr
    pkgs.nss
    pkgs.stdenv.cc.cc.lib
    pkgs.libx11
    pkgs.libxext
    pkgs.libxi
    pkgs.libxrender
    pkgs.libxtst
    pkgs.libxxf86vm
    pkgs.zlib
  ];

  incy = pkgs.stdenv.mkDerivation {
    pname = "incy";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/INCY-DEV/incy-platforms/releases/download/desktop-v${version}/incy-linux-x64-portable.zip";
      sha256 = "D2PIQCGmjkLsJnHLK23TD8zUeGOpQffWVhv63PkSYjU=";
    };

    nativeBuildInputs = [
      pkgs.unzip
      pkgs.autoPatchelfHook
      pkgs.makeWrapper
    ];

    buildInputs = runtimeLibs;

    sourceRoot = ".";

    # Игнорируем возможные старые зависимости внутри jpackage, если они не критичны
    autoPatchelfIgnoreMissingDeps = [
      "libasound.so.2"
    ];

    installPhase = ''
      mkdir -p $out/share/incy $out/bin $out/share/applications $out/share/icons/hicolor/256x256/apps

      cp -r incy/* $out/share/incy/
      chmod +x $out/share/incy/bin/incy
      find $out/share/incy -type f \( -name "java" -o -name "xray" -o -name "sing-box" -o -name "*helper*" \) -exec chmod +x {} +

      # Патчим все встроенные shell-скрипты (если они есть), чтобы они видели утилиты NixOS и SUID-обёртки
      find $out/share/incy -type f -exec grep -Il "^#!/" {} + | while read -r script; do
        sed -i '1a export PATH="/run/wrappers/bin:/run/current-system/sw/bin:$PATH"' "$script"
      done

      ln -s $out/share/incy/lib/incy.png $out/share/icons/hicolor/256x256/apps/incy.png

      # Оборачиваем бинарник с передачей всех библиотек и системных путей (включая /run/wrappers/bin для pkexec)
      makeWrapper $out/share/incy/bin/incy $out/bin/incy \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath runtimeLibs}" \
        --prefix PATH : "/run/wrappers/bin:${
          pkgs.lib.makeBinPath [
            pkgs.util-linux
            pkgs.coreutils
            pkgs.gnugrep
            pkgs.gnused
            pkgs.gawk
            pkgs.iptables
            pkgs.iproute2
            pkgs.nftables
          ]
        }" \
        --set _JAVA_AWT_WM_NONREPARENTING 1

      cat > $out/share/applications/incy.desktop << EOF
      [Desktop Entry]
      Name=INCY VPN
      Comment=Cross-platform proxy client
      Exec=$out/bin/incy %U
      Icon=incy
      Terminal=false
      Type=Application
      Categories=Network;VPN;
      MimeType=x-scheme-handler/incy;
      EOF
    '';
  };
in
{
  environment.systemPackages = [
    incy
  ];

  # Разрешаем запускать хелпер INCY через sudo без пароля для работы TUN и Kill Switch
  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "${incy}/share/incy/lib/app/resources/bin/incy-helper-linux.sh";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # 1. Разрешаем асимметричную маршрутизацию для TUN-интерфейса (критично для Xray/Sing-box TUN)
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.rp_filter" = 2;
    "net.ipv4.conf.default.rp_filter" = 2;
  };

  # 2. Отключаем проверку обратного пути в фаерволе NixOS (иначе NixOS режет пакеты от tun-интерфейса)
  networking.firewall.checkReversePath = "loose"; # или false, если loose не поможет

  environment.persistence."/persistent" = {
    users.jorlyf = {
      directories = [
        ".cache/incy"
        ".config/incy"
        ".local/share/incy"
      ];
    };
  };
}
