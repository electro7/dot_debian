" vim-airline companion theme of Hybrid
" (https://github.com/w0ng/vim-hybrid)
" Modified by e7

let g:airline#themes#air_e7#palette = {}

let s:N1 = [ '#000000' , '#b5bd68' , 'black' , 10      ]
let s:N2 = [ '#b5bd68' , '#373b41' , 15      , 8       ]
let s:N3 = [ '#ffffff' , '#282a2e' , 255     , 'black' ]
let g:airline#themes#air_e7#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#air_e7#palette.normal.airline_a = ['#000000', '#b5bd68', 16, 10, '']

let s:I1 = [ '#000000' , '#6a9fb5' , 'black' , 4       ]
let s:I2 = [ '#b5bd68' , '#373b41' , 15      , 8       ]
let s:I3 = [ '#ffffff' , '#282a2e' , 255     , 'black' ]
let g:airline#themes#air_e7#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#air_e7#palette.insert.airline_a = ['#000000', '#6a9fb5', 16, 4]
let g:airline#themes#air_e7#palette.insert_paste = {
            \ 'airline_a': ['#000000', '#ac4142', 16 , 4, ''] ,
            \ }

let g:airline#themes#air_e7#palette.replace = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#air_e7#palette.replace.airline_a = ['#000000', '#ac4142', 15, 1]

let g:airline#themes#air_e7#palette.visual = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#air_e7#palette.visual.airline_a = ['#000000', '#f0c674', 16, 11]

let s:IA1 = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
let s:IA2 = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
let s:IA3 = [ '#4e4e4e' , '#303030' , 239 , 236 , '' ]
let g:airline#themes#air_e7#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

let g:airline#themes#air_e7#palette.accents = {
      \ 'red': [ '#ff0000' , '' , 160 , ''  ]
      \ }
