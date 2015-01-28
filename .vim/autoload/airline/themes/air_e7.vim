" vim-airline companion theme of Hybrid_e7
" Base in (https://github.com/w0ng/vim-hybrid)
" E7 - 27 ene 2015

let g:airline#themes#air_e7#palette = {}

function! airline#themes#air_e7#refresh()

  " Normal mode
  let s:N1 = [ '#000000' , '#b5bd68' , 'black' , 10      ]
  let s:N2 = [ '#c5c8c6' , '#373b41' , 15      , 8       ]
  let s:N3 = [ '#c5c8c6' , '#282a2e' , 15      , 'black' ]
  let g:airline#themes#air_e7#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
  let g:airline#themes#air_e7#palette.normal.airline_a = ['#000000', '#b5bd68', 'black', 10, '']

  " Insert mode
  let s:I1 = [ '#000000' , '#de935f' , 'black'  , 3       ]
  let s:I2 = [ '#282a2e' , '#f0c674' , 'black'  , 11      ]
  let s:I3 = [ '#f0c674' , '#282a2e' , 11       , 'black' ]
  let g:airline#themes#air_e7#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
  let g:airline#themes#air_e7#palette.insert.airline_a = ['#000000', '#de935f', 'black', 3, '']
  let g:airline#themes#air_e7#palette.insert_paste = {
              \ 'airline_a': ['#000000', '#de935f', 'black', 3, ''] ,
              \ }

  " Replace mode
  let g:airline#themes#air_e7#palette.replace = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
  let g:airline#themes#air_e7#palette.replace.airline_a = ['#c5c8c6', '#a54242', 15, 1]
  let g:airline#themes#air_e7#palette.replace.airline_z = ['#c5c8c6', '#a54242', 15, 1]

  " Visual mode
  let g:airline#themes#air_e7#palette.visual = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
  let g:airline#themes#air_e7#palette.visual.airline_a = ['#000000', '#5f919d', 'black', 4]
  let g:airline#themes#air_e7#palette.visual.airline_z = ['#000000', '#5f919d', 'black', 4]

  " Inactive window
  let s:IA1 = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
  let s:IA2 = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
  let s:IA3 = [ '#4e4e4e' , '#303030' , 239 , 236 , '' ]
  let g:airline#themes#air_e7#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

  let g:airline#themes#air_e7#palette.accents = {
        \ 'red': [ '#ff0000' , '' , 160 , ''  ]
        \ }

endfunction

call airline#themes#air_e7#refresh()

