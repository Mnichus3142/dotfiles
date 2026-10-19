local vars = require("variables")
local fn   = require("hyprland.functions")

-- Hide NymVPN's first window to tray on login; later tray opens stay visible
local hide_nym_once = false

local function is_nym_vpn(win)
    local class = win and (win.class or win.initial_class) or ""
    return class == "nym-vpn-app"
end

hl.on("hyprland.start", function()
    -- Keyring and auth
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Clipboard history
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Auto delete trash 30 days old
    hl.exec_cmd("trash-empty 30")

    -- Cursors
    hl.exec_cmd("hyprctl setcursor " .. vars.cursorTheme .. " " .. vars.cursorSize)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme " .. vars.cursorTheme)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. vars.cursorSize)

    -- Location provider and night light
    hl.exec_cmd("/usr/lib/geoclue-2.0/demos/agent")
    hl.exec_cmd("sleep 1 && gammastep")

    -- Forward bluetooth media commands to MPRIS
    hl.exec_cmd("mpris-proxy")

    -- Start shell
    hl.exec_cmd("caelestia shell -d")

    -- Start usb watcher
    hl.exec_cmd("udiskie -a -n -t")

    -- Scratchpad apps: spawn onto hidden special workspaces without stealing focus
    hl.exec_cmd("equibop", { workspace = "special:communication silent" })
    hl.exec_cmd("spotify", { workspace = "special:music silent" })
    hl.exec_cmd("Telegram", { workspace = "special:telegram silent" })
    hl.exec_cmd("thunderbird", { workspace = "special:thunderbird silent" })

    -- Wait for tray host before starting NymVPN, otherwise it creates both
    -- ayatana + ksni icons (native fallback then "upgrade" without dropping the first).
    -- XDG autostart is disabled; close first window → tray.
    hide_nym_once = true
    hl.exec_cmd(
        "bash -c 'until busctl --user status org.kde.StatusNotifierWatcher >/dev/null 2>&1; do sleep 0.1; done; exec nym-vpn-app'",
        { workspace = "special:nym silent" }
    )
end)

-- Resizer listener
hl.on("window.title", function(win)
    local d = {
        hl.dsp.window.float({ action = "on", window = win }),
        hl.dsp.window.center({ window = win }),
    }
    local pip = fn.move_actions(win) or {}

    fn.resizer(win, "Bitwarden", 20, 54, d, true)
    fn.resizer(win, "Picture[- ]in[- ][Pp]icture", 0, 0, pip, false)
end)

hl.on("window.open", function(win)
    if hide_nym_once and is_nym_vpn(win) then
        hide_nym_once = false
        hl.dispatch(hl.dsp.window.close({ window = win }))
        return
    end

    local d = {
        hl.dsp.window.float({ action = "on", window = win }),
        hl.dsp.window.center({ window = win }),
    }
    local pip = fn.move_actions(win) or {}

    fn.resizer(win, "Bitwarden", 20, 54, d, true)
    fn.resizer(win, "Picture[- ]in[- ][Pp]icture", 0, 0, pip, false)
end)
