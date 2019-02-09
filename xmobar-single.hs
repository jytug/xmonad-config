-- xmobar config used by Vic Fryzel
-- Author: Vic Fryzel
-- https://github.com/vicfryzel/xmonad-config

-- This xmobar config is for a single 4k display (3840x2160) and meant to be
-- used with the stalonetrayrc-single config.
--
-- If you're using a single display with a different resolution, adjust the
-- position argument below using the given calculation.
Config {
    -- Position xmobar along the top, with a stalonetray in the top right.
    -- Add right padding to xmobar to ensure stalonetray and xmobar don't
    -- overlap. stalonetrayrc-single is configured for 12 icons, each 23px
    -- wide. 
    -- right_padding = num_icons * icon_size
    -- right_padding = 12 * 23 = 276
    -- Example: position = TopP 0 276
    position = Static { xpos = 0, ypos = 0, width = 1644, height = 23 },
    font = "xft:monospace-8",
    bgColor = "#000000",
    fgColor = "#ffffff",
    lowerOnStart = False,
    overrideRedirect = False,
    allDesktops = True,
    persistent = True,
    commands = [
        -- cpu stats
          Run MultiCpu          [ "-t",  "Cpu: <total0> <total1> <total2> <total3>"
                                , "-L",  "30"
                                , "-H",  "60"
                                , "-h",  "#FFB6B0"
                                , "-l",  "#CEFFAC"
                                , "-n",  "#FFFFCC"
                                , "-w",  "3"
                                ] 10
        -- memory stats
        , Run Memory            [ "-t",     "Mem: <usedratio>%"
                                , "-H",     "8192"
                                , "-L",     "4096"
                                , "-h",     "#FFB6B0"
                                , "-l",     "#CEFFAC"
                                , "-n",     "#FFFFCC"
                                ] 10
        -- swap
        , Run Swap              [ "-t",      "Swap: <usedratio>%"
                                , "-H",      "1024"
                                , "-L",      "512"
                                , "-h",      "#FFB6B0"
                                , "-l",      "#CEFFAC"
                                , "-n",      "#FFFFCC"
                                ] 10
        -- network and info
        , Run Wireless "wlp2s0" [ "-t", "<essid>"] 10
        , Run Network "wlp2s0"  [ "-t",      "Net: <rx>, <tx>"
                                , "-H",      "200"
                                , "-L",      "10"
                                , "-h",      "#FFB6B0"
                                , "-l",      "#CEFFAC"
                                , "-n",      "#FFFFCC"
                                ] 10
        -- volume
        , Run Com "getMasterVolume" [] "volumelevel" 10
        -- battery monitor
        , Run Battery        [ "--template" , "Batt: <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkgreen"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"   , "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"   , "<fc=#dAA520>Charging</fc>"
                                       -- charged status
                                       , "-i"   , "<fc=#006000>Charged</fc>"
                             ] 50

        -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "<fc=#ABABAB>%F (%a) %T</fc>" "date" 10

        -- keyboard layout indicator
        , Run Kbd            [ ("us(dvorak)" , "<fc=#00008B>DV</fc>")
                             , ("us"         , "<fc=#8B0000>US</fc>")
                             ]
        , Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%battery% %StdinReader%   %multicpu%   %memory%   %swap%   }{ Wifi: %wlp2s0wi% %wlp2s0%   Vol: <fc=#b2b2ff>%volumelevel%</fc>   <fc=#FFFFCC>%date%</fc> %kbd%"
}
