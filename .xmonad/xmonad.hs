-- default desktop configuration for Fedora

import System.Posix.Env (getEnv)
import Data.Maybe (maybe)

import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Config.Kde
import XMonad.Config.Xfce
import XMonad.Actions.PhysicalScreens
import qualified Data.Map as M

main = do
     session <- getEnv "DESKTOP_SESSION"
     let config = maybe desktopConfig desktop session
     xmonad  $ config{ keys = myKeys <+> keys config }

desktop "gnome" = gnomeConfig
desktop "kde" = kde4Config
desktop "xfce" = xfceConfig
desktop "xmonad-mate" = gnomeConfig
desktop _ = desktopConfig

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    [ 
    -- alt-z to launch terminal
    ((modMask,                   xK_z), spawn $ XMonad.terminal conf)
    -- ctrl-alt-l or multimedia suspend key to lock screen
    , ((modMask .|. controlMask, xK_l), spawn "xscreensaver-command -lock")
    , ((0,                 0x1008FF2F), spawn "xscreensaver-command -lock")
    -- super for run menu
    , ((0,                 xK_Super_L), spawn "dmenu_run")
    -- volume keys
    , ((0,                 0x1008FF11), spawn "amixer -q set Master 5%-")
    , ((0,                 0x1008FF13), spawn "amixer -q set Master 5%+")
    , ((0,                 0x1008FF12), spawn "amixer -q set Master toggle")
    -- spotify music controls
    , ((0,                 0x1008ff16), spawn "/u/jdito/.spotify.sh prev")
    , ((0,                 0x1008ff17), spawn "/u/jdito/.spotify.sh next")
    , ((0,                 0x1008ff14), spawn "/u/jdito/.spotify.sh pp")
    ]
    ++
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((modMask .|. mask, key), f sc)
     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
     , (f, mask) <- [(viewScreen, 0), (sendToScreen, shiftMask)]]

