" Bluez vim-airline base for console
" E7 - 08 sep 2019


" -----------------------------------------------------------------------------
" GUI Colors
" black
let s:g_d_black     = "#293E56"
let s:g_b_black     = "#3A5678"
" red
let s:g_d_red       = "#ED457D"
let s:g_b_red       = "#F48FB1"
" green
let s:g_d_green     = "#51E1AC"
let s:g_b_green     = "#A1EFD3"
" yellow
let s:g_d_yellow    = "#F1CB5B"
let s:g_b_yellow    = "#EDF78E"
" blue
let s:g_d_blue      = "#4583ED"
let s:g_b_blue      = "#92B6F4"
" magenta
let s:g_d_purple    = "#824DE6"
let s:g_b_purple    = "#C1A6F2"
" cyan
let s:g_d_cyan      = "#3BCBDE"
let s:g_b_cyan      = "#87DFEB"
" white
let s:g_d_white     = "#607C9F"
let s:g_b_white     = "#CDD7E6"
" extra gray
let s:g_d_gray      = "#3C4A5D"
let s:g_b_gray      = "#50637C"

" CTerm colors (256 color)
" black
let s:c_d_black     = "0"
let s:c_b_black     = "8"
" red
let s:c_d_red       = "1"
let s:c_b_red       = "9"
" green
let s:c_d_green     = "2"
let s:c_b_green     = "10"
" yellow
let s:c_d_yellow    = "3"
let s:c_b_yellow    = "11"
" blue
let s:c_d_blue      = "4"
let s:c_b_blue      = "12"
" magenta
let s:c_d_purple    = "5"
let s:c_b_purple    = "13"
" cyan
let s:c_d_cyan      = "6"
let s:c_b_cyan      = "14"
" white
let s:c_d_white     = "7"
let s:c_b_white     = "15"
" extra gray
let s:c_d_gray      = "8"
let s:c_b_gray      = "7"

" -----------------------------------------------------------------------------
" Palette:    guifg          guibg          termfg        termbg
" Normal mode
let s:N1 = [ s:g_b_blue   , s:g_b_black  , s:c_b_blue    , s:c_b_black   ]
let s:N2 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black   ]
let s:N3 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black   ]

" Insert mode
let s:I1 = [ s:g_b_green  , s:g_b_black  , s:c_b_green   , s:c_b_black  ]
let s:I2 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black  ]
let s:I3 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black  ]

" Visual mode
let s:V1 = [ s:g_b_purple , s:g_b_black  , s:c_b_purple  , s:c_b_black  ]
let s:V2 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black  ]
let s:V3 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black  ]

" Replace mode
let s:R1 = [ s:g_b_red    , s:g_b_black  , s:c_b_red     , s:c_b_black  ]
let s:R2 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black  ]
let s:R3 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black  ]

" Inactive window
let s:W1 = [ s:g_d_gray   , s:g_d_black  , s:c_d_gray    , s:c_d_black  ]
let s:W2 = [ s:g_d_gray   , s:g_d_black  , s:c_d_gray    , s:c_d_black  ]
let s:W3 = [ s:g_d_gray   , s:g_d_black  , s:c_d_gray    , s:c_d_black  ]

" Warning & Errors
let s:WA = [ s:g_b_black  , s:g_d_yellow , s:c_b_black   , s:c_d_yellow ]
let s:ER = [ s:g_d_black  , s:g_d_red    , s:c_d_black   , s:c_d_red    ]
"
let g:airline#themes#e7_bluez#palette = {}

" Normal mode
let g:airline#themes#e7_bluez#palette.normal =
  \ airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#e7_bluez#palette.normal.airline_a =
  \ [ s:g_d_black, s:g_b_blue , s:c_d_black, s:c_b_blue ]
let g:airline#themes#e7_bluez#palette.normal.airline_b =
  \ [ s:g_b_blue , s:g_d_black, s:c_b_blue , s:c_d_black]

" Insert mode
let g:airline#themes#e7_bluez#palette.insert =
  \ airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#e7_bluez#palette.insert.airline_a =
  \ [ s:g_d_black, s:g_b_green,  s:c_d_black, s:c_b_green ]
let g:airline#themes#e7_bluez#palette.insert.airline_b =
  \ [ s:g_b_green , s:g_d_black, s:c_b_green , s:c_d_black]

" Visual mode
let g:airline#themes#e7_bluez#palette.visual =
  \ airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#e7_bluez#palette.visual.airline_a =
  \ [ s:g_b_black, s:g_b_purple, s:c_b_black, s:c_b_purple ]
let g:airline#themes#e7_bluez#palette.visual.airline_b =
  \ [ s:g_b_purple , s:g_d_black, s:c_b_purple , s:c_d_black]

" Replace mode
let g:airline#themes#e7_bluez#palette.replace =
  \ airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#e7_bluez#palette.replace.airline_a =
  \ [ s:g_b_black, s:g_b_red, s:c_b_black, s:c_b_red ]
let g:airline#themes#e7_bluez#palette.replace.airline_b =
  \ [ s:g_b_red , s:g_d_black, s:c_b_red , s:c_d_black]
"
" Inactive window
let g:airline#themes#e7_bluez#palette.inactive =
  \ airline#themes#generate_color_map(s:W1, s:W2, s:W3)

" Warning
let g:airline#themes#e7_bluez#palette.normal.airline_warning = s:WA
let g:airline#themes#e7_bluez#palette.insert.airline_warning = s:WA
let g:airline#themes#e7_bluez#palette.visual.airline_warning = s:WA
let g:airline#themes#e7_bluez#palette.replace.airline_warning = s:WA

" Error
let g:airline#themes#e7_bluez#palette.normal.airline_error = s:ER
let g:airline#themes#e7_bluez#palette.insert.airline_error = s:ER
let g:airline#themes#e7_bluez#palette.visual.airline_error = s:ER
let g:airline#themes#e7_bluez#palette.replace.airline_error = s:ER

" vim: et ts=2 sts=2 sw=2 tw=80

