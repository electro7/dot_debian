" Vim color file
"
" Maintainer: Vicente Gimeno
" Last Change: 22 mar 2005	
" 
" Colores para fondo blanco.
" 
" Instalación:
"   Copiar to ~/.vim/colors; do :color fvwm_grey
"
" Ayuda
" :he group-name
" :he highlight-groups
" :he cterm-colors

" Limpia
set background=light
hi clear
if exists("syntax_on")
   syntax reset
endif

let colors_name = "white_e7"

"#----------------------------------------------------------------------#
"# Gui
"#----------------------------------------------------------------------#

hi Normal       guifg=#000000 guibg=#ffffff

" Search 
hi IncSearch    gui=NONE guifg=#00bb00 guibg=NONE
hi Search	 	gui=NONE guifg=#00bb00 guibg=NONE

" Messages 
hi ErrorMsg     gui=NONE guifg=#a00000 guibg=NONE
hi Warning30g   gui=NONE guifg=#800000 guibg=NONE
hi ModeMsg      gui=NONE guifg=#000080 guibg=NONE
hi MoreMsg      gui=NONE guifg=#000080 guibg=NONE
hi Question     gui=NONE guifg=#0000bb guibg=NONE

" Split area 
hi StatusLine   gui=NONE guifg=#ffff00 guibg=#6565bb
hi StatusLineNC gui=NONE guifg=#808080 guibg=#e0e0e0
hi VertSplit 	gui=NONE guifg=#000060 guibg=NONE
hi WildMenu     gui=NONE guifg=#f8f8f8 guibg=#000040

" Diff 
hi DiffText     gui=NONE guifg=#000000 guibg=#f0f0f0
hi DiffChange   gui=NONE guifg=#808080 guibg=#f0f0f0
hi DiffDelete   gui=NONE guifg=#000000 guibg=#ffeebb
hi DiffAdd      gui=NONE guifg=#000000 guibg=#ffccbb

" Cursor 
hi Cursor       gui=NONE guifg=#ffffff guibg=#000000
hi lCursor      gui=NONE guifg=#ffffff guibg=#000000
hi CursorIM     gui=BOLD guifg=#ffffff guibg=#000000

" Fold 
hi Folded       gui=NONE guifg=#000000 guibg=#e0e0e0
hi FoldColumn   gui=NONE guifg=#000000 guibg=#e0e0e0

" Other 
hi Directory    gui=NONE guifg=#000090 guibg=NONE
hi LineNr       gui=NONE guifg=#cd8162 guibg=NONE
hi NonText      gui=NONE guifg=#cd96cd guibg=NONE
hi SpecialKey   gui=NONE guifg=#ff00ff guibg=NONE
hi Title        gui=NONE guifg=#6ca6cd guibg=NONE
hi Visual       gui=NONE guifg=#f0f0f0 guibg=#000020

" Syntax group 
"hi Comment      gui=NONE guifg=#888488 guibg=NONE
hi Comment      gui=NONE guifg=#008000 guibg=NONE
hi Constant     gui=NONE guifg=#800080 guibg=NONE
hi Error        gui=NONE guifg=#ffffff guibg=#800000
hi Identifier   gui=NONE guifg=#000000 guibg=NONE
hi Ignore       gui=NONE guifg=#808080 guibg=NONE
hi PreProc      gui=NONE guifg=#000080 guibg=NONE
hi Special      gui=NONE guifg=#800000 guibg=NONE
hi Statement    gui=NONE guifg=#0000ff guibg=NONE
hi Todo         gui=NONE guifg=#ff00ff guibg=NONE
hi Type         gui=NONE guifg=#0000ff guibg=NONE
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

hi Cursor				cterm=NONE ctermfg=black	ctermbg=yellow
hi ErrorMsg			cterm=NONE ctermfg=red 		ctermbg=NONE 
hi ModeMsg			cterm=NONE ctermfg=Cyan 	ctermbg=NONE
hi statusline  	cterm=NONE ctermfg=yellow 	ctermbg=blue
hi statuslineNC	cterm=NONE ctermfg=yellow 	ctermbg=blue
hi LineNr       cterm=NONE ctermfg=red		ctermbg=NONE
hi Visual				cterm=NONE ctermfg=yellow 	ctermbg=magenta

" Syntax
hi Comment			cterm=NONE ctermfg=DarkGray ctermbg=NONE 
hi Constant			cterm=NONE ctermfg=Magenta 	ctermbg=NONE 
hi identifier		cterm=NONE ctermfg=cyan 	ctermbg=NONE 
hi Statement		cterm=NONE ctermfg=Yellow 	ctermbg=NONE 
hi PreProc 			cterm=NONE ctermfg=Blue 	ctermbg=NONE 
hi Type					cterm=NONE ctermfg=Green 	ctermbg=NONE 
hi Special			cterm=NONE ctermfg=Red 		ctermbg=NONE 
hi Ignore				cterm=NONE ctermfg=Brown 	ctermbg=NONE 
hi Error				cterm=NONE ctermbg=DarkRed 	ctermfg=White
hi Todo					cterm=NONE ctermfg=White 	ctermbg=NONE 
