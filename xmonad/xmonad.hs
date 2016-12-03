import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
{-import XMonad.Layout.Fullscreen-}
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition
import XMonad.Layout.NoBorders
import System.IO
import XMonad.Layout.ToggleLayouts
import XMonad.Hooks.EwmhDesktops

myManageHook = composeAll
	[ className =? "Nm-connection-editor" --> doFloat 
	, className =? "google-chrome" --> insertPosition Master Newer
	, className =? "Chromium" --> insertPosition Master Newer
	, className =? "feh" --> doCenterFloat
	, manageDocks
	{-, fullscreenManageHook-}
	, insertPosition End Newer
	, composeOne [isFullscreen -?> doFullFloat]
	]


main = do
	xmproc <- spawnPipe "xmobar"
	xmonad $ defaultConfig
		{ handleEventHook = fullscreenEventHook
		, manageHook = myManageHook <+> manageHook defaultConfig
		, layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
		, logHook = dynamicLogWithPP xmobarPP
				{ ppOutput = hPutStrLn xmproc
				, ppTitle = xmobarColor "green" "" . shorten 50
				}
		, terminal = "gnome-terminal"
		, focusFollowsMouse = False
		} `additionalKeys`
		[ ((mod1Mask .|. shiftMask, xK_l), spawn "light-locker-command -l")
		, ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
		, ((0, xK_Print), spawn "scrot")
		, ((mod1Mask, xK_c), spawn "chromium")
		] 


