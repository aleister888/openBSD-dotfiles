<img src="https://raw.githubusercontent.com/aleister888/openBSD-dotfiles/master/img/dwm.png" align="left" height="100px" hspace="30px">

## dwm - OpenBSD

dwm build for openBSD

## Keybindings

- `LAlt + o` dmenu
- `LAlt + b` Toggle bar
- `LAlt + q/w` Previous/Next tag
- `LAlt + z/x` Previous/Next Song
- `LAlt + Shift + z/x` Play-pause music
- Stack Keys
    - `LAlt + Minus` Focus/Move first master Window
        - `LAlt + Comma/Period` Focus/Move Previous/Next window
        - `LAlt + Left/Right` Focus/Move Previous/Next window
        - `LAlt + Stack Key` Focus window
        - `LAlt + Shift + Stack Key` Move window
- `LAlt + j/k` Add/Remove window to master
- `LAlt + u/i` Change window ratio
- `LAlt + Shift + u/i` Change window weight
- `LAlt + Shift + q` Close window
- `LAlt + Shift + F11` Restart dwm
- `LAlt + Shift + Space` Toggle Floating
- `LAlt + s` Toggle scratchpads
- `LAlt + Shift + s` Make window scratchpad
- `LAlt + Ctrl + s` Unmake window scratchpad
- `LAlt + Shift + a` Toggle windows stickiness
- `LAlt + f` Spawnscratchpad
- `LAlt + ´/ç` Focus Previous/Next monitor (Intended for Spanish keyboards)
- `LAlt + Shift + ´/ç` Send window to Previous/Next monitor (Intended for Spanish keyboards)
- `LAlt + e` Default layout
- `LAlt + r` Floating layout
- `LAlt + Shift + e` Monocle layout
- `LAlt + Shift + r` Centered master layout
- `LAlt + y` Columns layout
- `LAlt + Shift + y` Bottom stack layout
- `LAlt + 1/9` Move to tag 1/9
- `LAlt + Shift + 1/9` Move window to tag 1/9

## Patches

- [Urgent Border](https://dwm.suckless.org/patches/urgentborder/dwm-6.2-urg-border.diff)
- [Allowkill](https://dwm.suckless.org/patches/allowkillrule/dwm-allowkillrule-6.4.diff)
- [Alt tags decoration](https://dwm.suckless.org/patches/alttagsdecoration/dwm-alttagsdecoration-2020010304-cb3f58a.diff)
- [Always center](https://dwm.suckless.org/patches/alwayscenter/dwm-alwayscenter-20200625-f04cac6.diff)
- [Attach above](https://dwm.suckless.org/patches/attachabove/dwm-attachabove-6.2-20200421.diff)
- [Autostart](https://dwm.suckless.org/patches/autostart/dwm-autostart-20210120-cb3f58a.diff)
- [Bar Height](https://dwm.suckless.org/patches/bar_height/dwm-bar-height-spacing-6.3.diff)
- [Bar Padding](https://dwm.suckless.org/patches/barpadding/dwm-barpadding-6.2.diff)
- [Bottom Stack](https://dwm.suckless.org/patches/bottomstack/dwm-bottomstack-6.1.diff)
    - Added gaps
- [Cfacts](https://dwm.suckless.org/patches/cfacts/dwm-cfacts-20200913-61bb8b2.diff)
    - Added cfacts support for all layouts
- [Columns](https://dwm.suckless.org/patches/columns/dwm-columns-6.2.diff)
    - Added gaps
- [Colorbar](https://dwm.suckless.org/patches/colorbar/dwm-colorbar-6.2.diff)
- [Decoration Hints](https://dwm.suckless.org/patches/decoration_hints/dwm-decorhints-6.2.diff)
- [Desktop Icons](https://raw.githubusercontent.com/bakkeby/patches/master/dwm/dwm-desktop_icons-6.2.diff)
- [Fixborders](https://dwm.suckless.org/patches/alpha/dwm-fixborders-6.2.diff)
- [Fullgaps](https://dwm.suckless.org/patches/fullgaps/dwm-fullgaps-6.2.diff)
    - I removed the hability to change gaps on the fly (I've never used it).
- [Layout Menu](https://dwm.suckless.org/patches/layoutmenu/dwm-layoutmenu-6.2.diff)
- [Pertag](https://dwm.suckless.org/patches/pertag/dwm-pertag-20200914-61bb8b2.diff)
    - I removed the bar function from pertag so bar toggles for all tags.
- [Preserve on Restart](https://dwm.suckless.org/patches/preserveonrestart/dwm-preserveonrestart-6.3.diff)
- [Renamed scratchpads](https://raw.githubusercontent.com/bakkeby/patches/master/dwm/dwm-renamedscratchpads-6.3.diff)
- [Resize corners](https://raw.githubusercontent.com/bakkeby/patches/master/dwm/dwm-resizecorners-6.3.diff)
- [Savefloats](https://dwm.suckless.org/patches/save_floats/dwm-savefloats-20181212-b69c870.diff)
- [Selective fake fullscreen](https://dwm.suckless.org/patches/selectivefakefullscreen/dwm-selectivefakefullscreen-20201130-97099e7.diff)
- [Shift view clients](https://raw.githubusercontent.com/bakkeby/patches/master/dwm/dwm-shiftviewclients-6.2.diff)
- [Stacker](https://dwm.suckless.org/patches/stacker/dwm-stacker-6.2.diff)
- [Status2d](https://dwm.suckless.org/patches/status2d/dwm-status2d-6.3.diff)
- [Status all Monitors](https://dwm.suckless.org/patches/statusallmons/dwm-statusallmons-6.2.diff)
- [Steam](https://raw.githubusercontent.com/bakkeby/patches/master/dwm/dwm-steam-6.2.diff)
- [Sticky](https://dwm.suckless.org/patches/sticky/dwm-sticky-6.4.diff)
- [Swallow](https://dwm.suckless.org/patches/swallow/dwm-swallow-6.3.diff)
- [Tag layouts](https://dwm.suckless.org/patches/taglayouts/dwm-taglayouts-6.4.diff)
