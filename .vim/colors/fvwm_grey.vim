" Vim color file
"
"  Maintainer: Vicente Gimeno
" Last Change: 13-10-2002
" 
" Colores para el escritorio fvwm Grey.
" 
" Instalación:
"   Copiar to ~/.vim/colors; do :color fvwm_grey
"
" Ayuda
" :he group-name
" :he highlight-groups
" :he cterm-colors

" Limpia
set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let colors_name = "fvwm_grey"

"#----------------------------------------------------------------------#
"# Gui
"#----------------------------------------------------------------------#

"hi Normal       guifg=#c3c3c3 guibg=#313031
hi Normal       guifg=#c3c3c3 guibg=#103040

" Search 
hi IncSearch    gui=NONE guifg=#111111 guibg=#cdb79e
hi Search   	gui=NONE guifg=#111111 guibg=#cdb79e

" Messages 
hi ErrorMsg     gui=NONE guifg=#ff6a6a guibg=NONE
hi Warning30g   gui=NONE guifg=#ffd700 guibg=NONE
hi ModeMsg      gui=NONE guifg=#87ceff guibg=NONE
hi MoreMsg      gui=NONE guifg=#87ceff guibg=NONE
hi Question     gui=NONE guifg=#c1ffc1 guibg=NONE

" Split area 
"hi StatusLine   gui=NONE guifg=#f8f8f8 guibg=#414441
"hi StatusLineNC gui=NONE guifg=#b4b2b4 guibg=#414441
hi StatusLine   gui=NONE guifg=#f8f8f8 guibg=#204450
hi StatusLineNC gui=NONE guifg=#b4b2b4 guibg=#204450
hi VertSplit 	gui=NONE guifg=#f8f8f8 guibg=NONE
hi WildMenu     gui=NONE guifg=#f8f8f8 guibg=#000000

" Diff 
hi DiffText     gui=NONE guifg=#cd9b9b guibg=NONE
hi DiffChange   gui=NONE guifg=#006800 guibg=#d0ffd0
hi DiffDelete   gui=NONE guifg=#87ceff guibg=NONE
hi DiffAdd      gui=NONE guifg=#c3c3c3 guibg=NONE

" Cursor 
hi Cursor       gui=NONE guifg=#000000 guibg=#ffd700
hi lCursor      gui=NONE guifg=#000000 guibg=#ffd700
hi CursorIM     gui=BOLD guifg=#000000 guibg=#ffd700

" Fold 
hi Folded       gui=NONE guifg=#c4c2c4 guibg=#414121
hi FoldColumn   gui=NONE guifg=#c4c2c4 guibg=#414121

" Other 
hi Directory    gui=NONE guifg=#cdc9a5 guibg=NONE
hi LineNr       gui=NONE guifg=#cd8162 guibg=NONE
hi NonText      gui=NONE guifg=#cd96cd guibg=NONE
hi SpecialKey   gui=NONE guifg=#cd8162 guibg=NONE
hi Title        gui=NONE guifg=#6ca6cd guibg=NONE
hi Visual       gui=NONE guifg=#000000 guibg=#cdbe70

" Syntax group 
hi Comment      gui=NONE guifg=#888488 guibg=NONE
hi Constant     gui=NONE guifg=#cdc9a5 guibg=NONE
hi Error        gui=NONE guifg=#f8f8f8 guibg=#8b3a3a
hi Identifier   gui=NONE guifg=#b9d3ee guibg=NONE
hi Ignore       gui=NONE guifg=#204050 guibg=NONE
hi PreProc      gui=NONE guifg=#9bcd9b guibg=NONE
hi Special      gui=NONE guifg=#cd9b9b guibg=NONE
hi Statement    gui=NONE guifg=#b9d3ee guibg=NONE
hi Todo         gui=NONE guifg=#8b3a3a guibg=NONE
hi Type         gui=NONE guifg=#96cdcd guibg=NONE
hi Underlined   gui=UNDERLINE

" HTML 
hi htmlLink                 gui=UNDERLINE
hi htmlBold                 gui=BOLD
hi htmlBoldItalic           gui=BOLD,ITALIC
hi htmlBoldUnderline        gui=BOLD,UNDERLINE
hi htmlBoldUnderlineItalic  gui=BOLD,UNDERLINE,ITALIC
hi htmlItalic               gui=ITALIC
hi htmlUnderline            gui=UNDERLINE
hi htmlUnderlineItalic      gui=UNDERLINE,ITALIC
"
"#----------------------------------------------------------------------#
"# Consola
"#----------------------------------------------------------------------#

hi Cursor		cterm=NONE ctermfg=black	ctermbg=yellow
hi ErrorMsg		cterm=NONE ctermfg=red 		ctermbg=NONE 
hi ModeMsg		cterm=NONE ctermfg=Cyan 	ctermbg=NONE
hi statusline  	cterm=NONE ctermfg=yellow 	ctermbg=blue
hi statuslineNC	cterm=NONE ctermfg=yellow 	ctermbg=blue
hi LineNr       cterm=NONE ctermfg=red		ctermbg=NONE
hi Visual		cterm=NONE ctermfg=yellow 	ctermbg=magenta

" Syntax
hi Comment		cterm=NONE ctermfg=DarkGray ctermbg=NONE 
hi Constant		cterm=NONE ctermfg=Magenta 	ctermbg=NONE 
hi identifier	cterm=NONE ctermfg=cyan 	ctermbg=NONE 
hi Statement	cterm=NONE ctermfg=Yellow 	ctermbg=NONE 
hi PreProc 		cterm=NONE ctermfg=Blue 	ctermbg=NONE 
hi Type			cterm=NONE ctermfg=Green 	ctermbg=NONE 
hi Special		cterm=NONE ctermfg=Red 		ctermbg=NONE 
hi Ignore		cterm=NONE ctermfg=Brown 	ctermbg=NONE 
hi Error		cterm=NONE ctermbg=DarkRed 	ctermfg=White
hi Todo			cterm=NONE ctermfg=White 	ctermbg=NONE 
