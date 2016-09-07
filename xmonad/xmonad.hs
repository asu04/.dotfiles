import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.Fullscreen
import XMonad.Hooks.ManageHelpers
import XMonad.Layout
import System.IO

myManageHook = composeAll
	[ className =? "Nm-connection-editor" --> doFloat
	, manageDocks
	, isFullscreen --> doFullFloat
	]


main = do
	xmproc <- spawnPipe "xmobar"
	xmonad $ defaultConfig
		{ manageHook = myManageHook <+> manageHook defaultConfig
		, layoutHook = avoidStruts $ layoutHook defaultConfig
		, logHook = dynamicLogWithPP xmobarPP
				{ ppOutput = hPutStrLn xmproc
				, ppTitle = xmobarColor "green" "" . shorten 50
				}
		, terminal = "gnome-terminal"
		, focusFollowsMouse = False
		}


