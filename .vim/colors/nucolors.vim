" Vim color scheme
"
" Name:        nucolors.vim
" Maintainer:  Christian Brassat <crshd@mail.com>
" License:     public domain
"
" Based on a port of the RailsCasts TextMate theme [1] to Vim.
" Some parts of this theme were borrowed from the well-documented Lucius theme [2].
" 
" [1] http://railscasts.com/about 
" [2] http://www.vim.org/scripts/script.php?script_id=2536

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "nucolors"

" Colors
" Brown        #FFFFB9
" Dark Blue    #7DC1CF
" Dark Green   #B8D68F
" Dark Orange  #E1AA5D
" Light Blue   #4E9FB1
" Light Green  #A0CF5D
" Tan          #F39D21
" Red          #E84F4F
"
hi Nontext                   guifg=#404040
hi Normal                    guifg=#E6E1DC guibg=#151515
hi Cursor                    guibg=#FF8939
hi CursorLine                guibg=#202020
hi LineNr                    guifg=#665544 guibg=#101010
hi Search                    guibg=#5A647E
hi VertSplit                 guifg=#1b1b1b guibg=#1b1b1b
hi Visual                    guibg=#5A647E

" Folds
" line used for closed folds
hi Folded                    guifg=#5A647E guibg=#202020 
hi FoldColumn                guifg=#505050 guibg=#050505

" Misc
" ----
" directory names and other special names in listings
hi Directory                 guifg=#A0CF5D 

" Popup Menu
" ----------
" normal item in popup
hi Pmenu                     guifg=#F6F3E8 guibg=#444444 
" selected item in popup
hi PmenuSel                  guifg=#000000 guibg=#A0CF5D 
" scrollbar in popup
hi PMenuSbar                 guibg=#5A647E 
" thumb of the scrollbar in the popup
hi PMenuThumb                guibg=#AAAAAA 


"rubyComment
hi Comment                   guifg=#809080 
hi Todo                      guifg=#809080 guibg=NONE 

"Invisibles
hi NonText                   guifg=#665544
hi SpecialKey                guifg=#665544

"rubyPseudoVariable
"nil, self, symbols, etc
hi Constant                  guifg=#7DC1CF

"rubyClass, rubyModule, rubyDefine
"def, end, include, etc
hi Define                    guifg=#FFFFB9 gui=bold

"rubyInterpolation
hi Delimiter                 guifg=#B8D68F

"rubyError, rubyInvalidVariable
hi Error                     guifg=#FFFFFF guibg=#990000

"rubyFunction
hi Function                  guifg=#E84F4F gui=bold 

"rubyIdentifier
"@var, @@var, $var, etc
hi Identifier                guifg=#4E9FB1 

"rubyInclude
"include, autoload, extend, load, require
hi Include                   guifg=#E1AA5D gui=bold 

"rubyKeyword, rubyKeywordAsMethod
"alias, undef, super, yield, callcc, caller, lambda, proc
hi Keyword                   guifg=#E1AA5D

" same as define
hi Macro                     guifg=#E1AA5D 

"rubyInteger
hi Number                    guifg=#A0CF5D

" #if, #else, #endif
hi PreCondit                 guifg=#E1AA5D 

" generic preprocessor
hi PreProc                   guifg=#E1AA5D 

"rubyControl, rubyAccess, rubyEval
"case, begin, do, for, if unless, while, until else, etc.
hi Statement                 guifg=#E1AA5D 

"rubyString
hi String                    guifg=#A0CF5D

hi Title                     guifg=#FFFFFF

"rubyConstant
hi Type                      guifg=#E84F4F 

hi DiffAdd                   guifg=#E6E1DC guibg=#144212
hi DiffDelete                guifg=#E6E1DC guibg=#660000

hi link htmlTag              xmlTag
hi link htmlTagName          xmlTagName
hi link htmlEndTag           xmlEndTag

hi xmlTag                    guifg=#E8BF6A
hi xmlTagName                guifg=#E8BF6A
hi xmlEndTag                 guifg=#E8BF6A

" Status line - changes colors depending on insert mode
" Standard
hi User1          guifg=#E8BF6A   guibg=#202020   gui=bold
hi User2          guifg=#E84F4F   guibg=#202020   gui=bold
hi User3          guifg=#A0CF5D   guibg=#202020   gui=bold
hi User4          guifg=#202020   guibg=#E8BF6A   gui=bold
hi User5          guifg=#909090   guibg=#202020   
hi User6          guifg=#40352D   guibg=#202020   
hi User7          guifg=#202020   guibg=#202020   gui=bold
hi StatusLine     guifg=#E6E1DC   guibg=#202020   gui=bold
hi StatusLineNC   guifg=#606060   guibg=#202020   gui=bold

function! InsertStatuslineColor(mode)

  if a:mode == 'i' " Insert Mode
    hi User4      guifg=#202020   guibg=#7DC1CF

  elseif a:mode == 'r' " Replace Mode
    hi User4      guifg=#202020   guibg=#E84F4F

  else
    hi User4      guifg=#202020   guibg=#E8BF6A

  endif
endfunction

" Call function
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guifg=#E6E1DC   guibg=#202020
au InsertLeave * hi User4      guifg=#202020   guibg=#E8BF6A
