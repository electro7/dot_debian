" =============================================================================
" Filename: autoload/lightline/colorscheme/e7_hybrid.vim
" Author: electro7
" License: MIT License
" Last Change: 14 sep 2019
" =============================================================================

" Reloading inside vim
" :source <theme.vim file>
" :call lightline#init() | call lightline#colorscheme() | call lightline#update()
"
let s:d_black  = [ "#282a2e" , 0      ]
let s:b_black  = [ "#373b41" , 8      ]
let s:d_red    = [ "#a54242" , 1      ]
let s:b_red    = [ "#cc6666" , 9      ]
let s:d_green  = [ "#8C9440" , 2      ]
let s:b_green  = [ "#b5bd68" , 10     ]
let s:d_yellow = [ "#de935f" , 3      ]
let s:b_yellow = [ "#f0c674" , 11     ]
let s:d_blue   = [ "#5f819d" , 4      ]
let s:b_blue   = [ "#81a2be" , 12     ]
let s:d_purple = [ "#85678f" , 5      ]
let s:b_purple = [ "#b294bb" , 13     ]
let s:d_cyan   = [ "#5e8d87" , 6      ]
let s:b_cyan   = [ "#8abeb7" , 14     ]
let s:d_white  = [ "#707880" , 7      ]
let s:b_white  = [ "#c5c8c6" , 15     ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {},
  \ 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ [ s:d_black, s:b_green ] , [ s:b_green, s:b_black ] ]
let s:p.insert.left = [ [ s:d_black, s:b_yellow ] , [ s:b_yellow, s:b_black ] ]
let s:p.visual.left = [ [ s:d_black, s:b_purple ] , [ s:b_purple, s:b_black ] ]
let s:p.replace.left = [ [ s:d_black, s:b_red ] , [ s:b_red, s:b_black ] ]

let s:p.normal.right = [ [ s:d_black, s:b_green ] , [ s:d_black , s:b_green ] ]
let s:p.insert.right = [ [ s:d_black, s:b_yellow ] , [ s:d_black, s:b_yellow ] ]
let s:p.visual.right = [ [ s:d_black, s:b_purple ] , [ s:d_black, s:b_purple ] ]
let s:p.replace.right = [ [ s:d_black, s:b_red ] , [ s:d_black, s:b_red ] ]

let s:p.inactive.left = [ [ s:d_white, s:d_black ] ]
let s:p.inactive.right= [ [ s:d_black, s:d_black ] , [ s:d_black, s:d_black ] ]
let s:p.inactive.middle = [ [ s:b_black, s:d_black ] ]

let s:p.normal.middle = [ [ s:d_white, s:d_black ] ]
let s:p.normal.error = [ [ s:d_black, s:d_red ]  ]
let s:p.normal.warning = [ [ s:d_black, s:d_yellow ] ]

let s:p.tabline.left = [ [ s:d_white, s:d_black ] ]
let s:p.tabline.tabsel = [ [ s:d_black, s:b_green ] ]
let s:p.tabline.middle = [ [ s:d_white, s:d_black ] ]
let s:p.tabline.right = copy(s:p.tabline.left)

let g:lightline#colorscheme#e7_hybrid#palette = lightline#colorscheme#flatten(s:p)
