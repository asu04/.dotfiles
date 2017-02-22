import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import qualified XMonad.Hooks.DynamicBars as Bars
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
{-import XMonad.Layout.Fullscreen-}
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition
import XMonad.Layout.NoBorders
import System.IO
import XMonad.Layout.ToggleLayouts
import XMonad.Hooks.EwmhDesktops
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowNavigation

onAllWS f = windows $ \ws@W.StackSet{ W.current = c, W.visible = vs } ->
        let screenNext x = W.current . f $ ws{ W.current = x }
            c':vs' = map screenNext (c:vs)
        in ws{ W.current = c', W.visible = vs'}


myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myManageHook = composeAll
	[ className =? "Nm-connection-editor" --> doFloat 
	, className =? "google-chrome" --> insertPosition Master Newer
	, className =? "Chromium" --> insertPosition Master Newer
	, className =? "feh" --> doCenterFloat
        , className =? "octave-gui" --> doCenterFloat
	, manageDocks
	{-, fullscreenManageHook-}
	, insertPosition End Newer
	, composeOne [isFullscreen -?> doFullFloat]
	]

barCreator :: Bars.DynamicStatusBar
barCreator (XMonad.S sid) = spawnPipe $ "xmobar --screen " ++ show sid

barDestroyer :: Bars.DynamicStatusBarCleanup
barDestroyer = return ()

main = do
    config <- withWindowNavigation (xK_w, xK_a, xK_s, xK_d)
	  $ defaultConfig
		{ startupHook = do Bars.dynStatusBarStartup barCreator barDestroyer 
                , workspaces = myWorkspaces 
                , handleEventHook = fullscreenEventHook
		, manageHook = myManageHook <+> manageHook defaultConfig
		, layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
		, logHook = Bars.multiPP (xmobarPP)
				{-{ppTitle = xmobarColor "green" "" . shorten 50-}
                                         (xmobarPP
                                         { ppCurrent = xmobarColor "white" "" . wrap "<" ">"
                                         , ppVisible = wrap "[" "]"
                                         }
                                         )
		, terminal = "gnome-terminal"
		, focusFollowsMouse = False
		} `additionalKeys` myKeys
    xmonad config
		

myKeys = [ ((mod1Mask .|. shiftMask, xK_l), spawn "light-locker-command -l")
	 , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
	 , ((0, xK_Print), spawn "scrot")
	 , ((mod1Mask, xK_c), spawn "chromium")
         , ((mod1Mask, xK_r), moveTo Next NonEmptyWS)
         , ((mod1Mask, xK_n), swapNextScreen)
         ]
         ++
         [((m .|. mod1Mask, k), windows $ f i)
                | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
                , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]



