import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ShowWName
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

import System.IO
import System.Exit
 
import qualified XMonad.StackSet as W

myManageHook = composeAll . concat $
    [ [ className =? c --> doFloat          | c <- myFloats]
    , [ title     =? t --> doFloat          | t <- myOtherFloats]
    , [ resource  =? "desktop_window" --> doIgnore]
    , [ resource  =? "kdesktop"       --> doIgnore]
    , [ resource  =? "stalonetray"         --> doIgnore]
    , [ className   =? c --> doF (W.shift "Browser") | c <- browserApps]
    , [ className   =? c --> doF (W.shift "Chat") | c <- chatApps]
    , [ className   =? c --> doF (W.shift "Mail") | c <- mailApps]
    , [ className   =? c --> doF (W.shift "Music") | c <- musicApps]
    , [ className   =? c --> doF (W.shift "Edit") | c <- editApps]
    , [ className   =? c --> doF (W.shift "Zim") | c <- zimApps]
    , [ className   =? c --> doF (W.shift "VirtualBox") | c <- vboxApps]
    ]   
 where
   myFloats      = ["MPlayer"]
   myOtherFloats = ["alsamixer",".", "Firefox Preferences", "Selenium IDE", "pinentry"]
   browserApps   = ["firefox", "Iceweasel", "Google-chrome", "Chromium-browser"]
   chatApps      = ["psi","Jitsi","Pidgin"]
   mailApps      = ["Kmail"]
   editApps      = ["Eclipse","sublime_text"]
   musicApps     = ["Amarok", "Rhythmbox", "Clementine"]
   zimApps       = ["Zim"]
   vboxApps      = ["VirtualBox"]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , workspaces = ["Shell","Browser","Edit","Zim","Mail","Chat","Tomcat","Music","VirtualBox"]
        , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig 
--        http://haskell.org/haskellwiki/Xmonad/Config_archive/webframp%27s_xmonad.hs
--        , layoutHook = avoidStruts $ smartBorders ( onWorkspace "Browser" Full ) $ layoutHook defaultConfig
--        , layoutHook = Full $ onWorkspace "Browser" Full 
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        -- , terminal = "urxvtc -tn rxvt"
        , terminal = "urxvtc"
        , normalBorderColor = "#4f4e4c"
        , focusedBorderColor = "#ffffff"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod4Mask .|. shiftMask, xK_m), spawn "disper --extend --direction=right; xrandr --output DP-0 --primary; /home/thorsten/bin/restart_trayer.sh")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((mod4Mask, xK_Print), spawn "sleep 0.2; scrot '%Y-%m-%d_%H-%M.png' -s -e 'mkdir -p /tmp/screenshots; mv $f /tmp/screenshots'")
        ]
