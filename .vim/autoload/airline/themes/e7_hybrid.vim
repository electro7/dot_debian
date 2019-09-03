" Hybrid vim-airline base for console
" E7 - 01 sep. 2019

" --------------------------------------------------------------------------------
" GUI Colors
" black
let s:g_d_black     = "#282A2E"
let s:g_b_black     = "#373B41"
" red
let s:g_d_red       = "#A54242"
let s:g_b_red       = "#CC6666"
" green
let s:g_d_green     = "#8C9440"
let s:g_b_green     = "#B5BD68"
" yellow
let s:g_d_yellow    = "#DE935F"
let s:g_b_yellow    = "#F0C674"
" blue
let s:g_d_blue      = "#5F819D"
let s:g_b_blue      = "#81A2BE"
" magenta
let s:g_d_purple    = "#85678F"
let s:g_b_purple    = "#B294BB"
" cyan
let s:g_d_cyan      = "#5E8D87"
let s:g_b_cyan      = "#8ABEB7"
" white
let s:g_d_white     = "#707880"
let s:g_b_white     = "#C5C8C6"
" extra gray
let s:g_d_gray      = "#1c1c1c"
let s:g_b_gray      = "#3d3d3d"

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
let s:c_d_gray      = "234"
let s:c_b_gray      = "239"

" --------------------------------------------------------------------------------
" Palette:    guifg          guibg          termfg        termbg
" Normal mode
let s:N1 = [ s:g_b_green  , s:g_b_black  , s:c_b_green   , s:c_b_black   ]
let s:N2 = [ s:g_d_green  , s:g_d_black  , s:c_d_green   , s:c_d_black   ]
let s:N3 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black   ]

" Insert mode
let s:I1 = [ s:g_b_yellow , s:g_b_black  , s:c_b_yellow  , s:c_b_black  ]
let s:I2 = [ s:g_d_yellow , s:g_d_black  , s:c_d_yellow  , s:c_d_black  ]
let s:I3 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black  ]

" Visual mode
let s:V1 = [ s:g_b_cyan   , s:g_b_black  , s:c_b_cyan    , s:c_b_black  ]
let s:V2 = [ s:g_d_cyan   , s:g_d_black  , s:c_d_cyan    , s:c_d_black  ]
let s:V3 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black  ]

" Replace mode
let s:R1 = [ s:g_b_red    , s:g_b_black  , s:c_b_red     , s:c_b_black  ]
let s:R2 = [ s:g_d_red    , s:g_d_black  , s:c_d_red     , s:c_d_black  ]
let s:R3 = [ s:g_d_white  , s:g_d_black  , s:c_d_white   , s:c_d_black  ]

" Inactive window
let s:W1 = [ s:g_b_gray   , s:g_d_black  , s:c_b_gray    , s:c_d_black  ]
let s:W2 = [ s:g_b_gray   , s:g_d_black  , s:c_b_gray    , s:c_d_black  ]
let s:W3 = [ s:g_b_gray   , s:g_d_black  , s:c_b_gray    , s:c_d_black  ]

" Warning & Errors
let s:WA = [ s:g_b_black  , s:g_d_yellow , s:c_b_black   , s:c_d_yellow ]
let s:ER = [ s:g_d_black  , s:g_d_red    , s:c_d_black   , s:c_d_red    ]
"
let g:airline#themes#e7_hybrid#palette = {}

" Normal mode
let g:airline#themes#e7_hybrid#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#e7_hybrid#palette.normal.airline_a = [ s:g_d_black, s:g_b_green, s:c_d_black, s:c_b_green ]

" Insert mode
let g:airline#themes#e7_hybrid#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#e7_hybrid#palette.insert.airline_a = [ s:g_d_black, s:g_b_yellow, s:c_d_black, s:c_b_yellow ]

" Visual mode
let g:airline#themes#e7_hybrid#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#e7_hybrid#palette.visual.airline_a = [ s:g_d_black, s:g_b_cyan, s:c_d_black, s:c_b_cyan ]

" Replace mode
let g:airline#themes#e7_hybrid#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#e7_hybrid#palette.replace.airline_a = [ s:g_d_black, s:g_b_red, s:c_d_black, s:c_b_red ]
"
" Inactive window
let g:airline#themes#e7_hybrid#palette.inactive = airline#themes#generate_color_map(s:W1, s:W2, s:W3)
let g:airline#themes#e7_hybrid#palette.inactive.airline_a = [ s:g_b_gray , s:g_b_black, s:c_b_gray, s:c_b_black ]

" Warning
let g:airline#themes#e7_hybrid#palette.normal.airline_warning = s:WA
let g:airline#themes#e7_hybrid#palette.insert.airline_warning = s:WA
let g:airline#themes#e7_hybrid#palette.visual.airline_warning = s:WA
let g:airline#themes#e7_hybrid#palette.replace.airline_warning = s:WA

" Error
let g:airline#themes#e7_hybrid#palette.normal.airline_error = s:ER
let g:airline#themes#e7_hybrid#palette.insert.airline_error = s:ER
let g:airline#themes#e7_hybrid#palette.visual.airline_error = s:ER
let g:airline#themes#e7_hybrid#palette.replace.airline_error = s:ER

" vim: et ts=2 sts=2 sw=2 tw=80

