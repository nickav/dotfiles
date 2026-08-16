-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Prewarm the default browser hidden at login so the first real open isn't a cold start.
-- omarchy-prewarm-browser resolves the live xdg default (whatever `xdg-settings get
-- default-web-browser` currently says) and skips entirely in Power Saver mode, since an
-- idle background browser process just burns battery for no benefit.
hl.on("hyprland.start", function()
  hl.dispatch(hl.dsp.exec_cmd("omarchy-prewarm-browser", { workspace = "special:prewarm silent" }))
end)
