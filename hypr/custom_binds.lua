-- custom_binds.lua
-- Converted from custom_binds.conf

local mainMod = "SUPER"
local terminal = "kitty --single-instance"

-- Basilk - task manager
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal .. " --class floatingTerm --title basilkTerm -e basilk"))

-- Basilk_pe - phys education task manager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal .. " --class floatingTerm --title basilkPETerm -e basilk_pe"))

-- Python - for calculations
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(terminal .. " --class floatingTerm --title pythonCalcTerm -e python -i /home/stanik/.config/pythonrc"))

-- Nvim - quick notes
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(terminal .. " --class=floatingTerm --title vimNotes -e sh -c \"nvim '/home/stanik/temp/note_$(date +'%Y-%m-%d').md'\""))

-- Clipboard history
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(terminal .. " --class=floatingTerm -e sh -c \"cliphist list | fzf --no-sort | cliphist decode | wl-copy\""))

-- last saved screenshot (detached)
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd(terminal .. " --class=floatingTerm --title screenshots -e sh -c \"cd /home/stanik/pics/screenshots/ && ls -t | fzf --no-sort | xargs xdg-open\""))

-- Wayshot - screenshot (region)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("sh -c 'file_path=~/pics/screenshots/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png && wayshot -s \"$(slurp)\" -f \"$file_path\" && wl-copy < \"$file_path\"'"))

-- Wayshot - screenshot (full screen)
hl.bind("Print", hl.dsp.exec_cmd("sh -c 'file_path=~/pics/screenshots/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png && wayshot -f \"$file_path\" && wl-copy < \"$file_path\"'"))

-- Lock screen
hl.bind(mainMod .. "+ SHIFT + slash", hl.dsp.exec_cmd("hyprlock"))

-- Volumes (using binde for repeating)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("amixer -M sset Master 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("amixer -M sset Master 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Media controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.playerctld /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.playerctld /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.playerctld /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"))

-- Bluetooth autoconnect headset
hl.bind(mainMod .. "+ SHIFT + F8", hl.dsp.exec_cmd("/home/stanik/scripts/someRandomThing/autoconnect_headset/btautoconnect.sh"))
