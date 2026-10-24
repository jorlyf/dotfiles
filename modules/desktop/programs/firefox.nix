{
  ...
}:
{
  programs.firefox = {
    enable = true;
    preferences = {
      "media.ffmpeg.vaapi.enabled" = true;
      "media.hardware-video-decoding.force-enabled" = true;
      "media.rdd-ffmpeg.enabled" = true;
      "gfx.x11-egl.force-enabled" = true;
      "widget.dmabuf.force-enabled" = true;
      "media.av1.enabled" = true;
    };
  };

  environment = {
    sessionVariables = {
      MOZ_DISABLE_RDD_SANDBOX = "1";
    };
    persistence."/persistent" = {
      users.jorlyf = {
        directories = [
          ".config/mozilla/firefox"
        ];
        files = [
          ".mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json"
        ];
      };
    };
  };
}
