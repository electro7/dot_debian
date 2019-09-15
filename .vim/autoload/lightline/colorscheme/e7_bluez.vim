" =============================================================================
" Filename: autoload/lightline/colorscheme/e7_bluez.vim
" Author: electro7
" License: MIT License
" Last Change: 14 sep 2019
" =============================================================================

" Reloading inside vim
" :source <theme.vim file>
" :call lightline#init() | call lightline#colorscheme() | call lightline#update()
"
let s:d_black  = [ "#293E56" , 0      ]
let s:b_black  = [ "#3a5678" , 8      ]
let s:d_red    = [ "#ed457d" , 1      ]
let s:b_red    = [ "#f48fb1" , 9      ]
let s:d_green  = [ "#51e1ac" , 2      ]
let s:b_green  = [ "#a1efd3" , 10     ]
let s:d_yellow = [ "#f1cb5b" , 3      ]
let s:b_yellow = [ "#edf78e" , 11     ]
let s:d_blue   = [ "#537bac" , 4      ]
let s:b_blue   = [ "#92b6f4" , 12     ]
let s:d_purple = [ "#824de6" , 5      ]
let s:b_purple = [ "#c1a6f2" , 13     ]
let s:d_cyan   = [ "#3bcbde" , 6      ]
let s:b_cyan   = [ "#87dfeb" , 14     ]
let s:d_white  = [ "#607c9f" , 7      ]
let s:b_white  = [ "#cdd7e6" , 15     ]
let s:d_gray   = [ "#3c4a5d" , 8      ]
let s:b_gray   = [ "#50637c" , 7      ]
let s:none     = [ "NONE"    , "NONE" ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {},
  \ 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ [ s:d_black, s:b_blue  ] , [ s:b_blue, s:b_black ] ]
let s:p.insert.left = [ [ s:d_black, s:b_green ] , [ s:b_green, s:b_black ] ]
let s:p.visual.left = [ [ s:d_black, s:b_yellow ] , [ s:b_yellow, s:b_black ] ]
let s:p.replace.left = [ [ s:d_black, s:b_red ] , [ s:b_red, s:b_black ] ]

let s:p.normal.right = [ [ s:d_black, s:b_blue ] , [ s:d_black , s:b_blue ] ]
let s:p.insert.right = [ [ s:d_black, s:b_green ] , [ s:d_black, s:b_green ] ]
let s:p.visual.right = [ [ s:d_black, s:b_yellow ] , [ s:d_black, s:b_yellow ] ]
let s:p.replace.right = [ [ s:d_black, s:b_red ] , [ s:d_black, s:b_red ] ]

let s:p.inactive.left = [ [ s:d_white, s:d_black ] ]
let s:p.inactive.right= [ [ s:d_black, s:d_black ] , [ s:d_black, s:d_black ] ]
let s:p.inactive.middle = [ [ s:b_black, s:d_black ] ]

let s:p.normal.middle = [ [ s:d_white, s:d_black ] ]
let s:p.normal.error = [ [ s:d_black, s:d_red ]  ]
let s:p.normal.warning = [ [ s:d_black, s:d_yellow ] ]

let s:p.tabline.left = [ [ s:d_white, s:d_black ] ]
let s:p.tabline.tabsel = [ [ s:d_black, s:b_blue ] ]
let s:p.tabline.middle = [ [ s:d_white, s:d_black ] ]
let s:p.tabline.right = copy(s:p.tabline.left)

let g:lightline#colorscheme#e7_bluez#palette = lightline#colorscheme#flatten(s:p)
