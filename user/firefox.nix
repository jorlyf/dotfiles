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

  environment.sessionVariables = {
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };
}
