" ~/.vimrcOA
"
" Archivo de configuración del editor VIM (er mejo!)
"
" Trato que funcione tanto en WIN (con gvim) como en LINUX (vim y gvim)
" Configuración ontenida de W0ng -> https://github.com/w0ng
"
" - linux -> ~/.vimrc
" - win -> $HOME/_vimrc
"
" Electro7 - Version 3.4 - 15 sep 2019
"==============================================================================

" Vim Plugins {{{
" -----------------------------------------------------------------------------
"
" Brief help
" :PluginList           - lists configured plugins
" :PluginInstall        - installs plugins
" :PluginUpdate         - Update Plugins
" :PluginSearch foo     - searches for foo; append `!` to refresh local cache
" :PluginClean          - confirms removal of unused plugins
" :h vundle for more details or wiki for FAQ

set runtimepath+=~/.vim/bundle/Vundle.vim
if has("win32") | set runtimepath+=~/.vim | endif

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
"Plugin 'Shougo/neocomplete'                " Automatic keyword completion
"Plugin 'Shougo/unite.vim'                  " Find files and buffers using ag
"Plugin 'bling/vim-airline'                  " Pretty statusbar :h vim-airline
"Plugin 'edkolev/promptline.vim'             " Prompt generator for bash
"Plugin 'godlygeek/tabular'                  " Text alignment (:h tabular)
Plugin 'itchyny/lightline.vim'              " Light statusbar
Plugin 'mengelbrecht/lightline-bufferline'  " Light bufferline
Plugin 'scrooloose/nerdtree'                " File Explorer
Plugin 'ctrlpvim/ctrlp.vim'                 " file, buffer, tag... finder
Plugin 'majutsushi/tagbar'                  " Display tags in a window
Plugin 'tpope/vim-fugitive'                 " Git wrapper (:h fugitive)
Plugin 'airblade/vim-gitgutter'             " Show git diffs (:h gitgutter)
Plugin 'tpope/vim-surround'                 " Quotes and brackets(:h surround)
Plugin 'terryma/vim-multiple-cursors'       " :h vim-multiple-cursors-intro
Plugin 'plasticboy/vim-markdown'            " Markdown integration
Plugin 'christoomey/vim-tmux-navigator'     " Move easy between tmux and vim
Plugin 'tmux-plugins/vim-tmux-focus-events' " Best tmux+vim integration
Plugin 'Yggdroot/indentLine'                " Show indent lines
Plugin 'junegunn/vim-easy-align'            " Tabular replacement
Plugin 'qpkorr/vim-bufkill'                 " Kill current buffer
Plugin 'mileszs/ack.vim'                    " ACK (vimgrep replacement)
call vundle#end()

"}}}
" Settings {{{
" -----------------------------------------------------------------------------

" No vi compatible
if &compatible | set nocompatible | endif

" Encoding
sil! set encoding=utf-8 fileencoding=utf-8 fileformats=unix,dos,mac
sil! set fileencodings=utf-8,latin1,default

" Appareance
sil! set background=dark colorcolumn=0 number cursorline noshowmode showbreak=
sil! set noshowmatch title noerrorbells splitright noshowcmd cmdwinheight=10
sil! set fillchars+=vert:┃ conceallevel=2 concealcursor=nc more laststatus=2
sil! set showtabline=2 list lcs=tab:+·,nbsp:_
sil! set statusline=%t\ %=\ %m%r%y%w\ %3l:%-2c
if has('gui_running') | sil! set guifont=Consolas:h9 lines=60 columns=90
  \ guioptions=c guicursor+=a:block-blinkon0 | else | set t_Co=256 | endif

" Editing
sil! set autoindent expandtab shiftwidth=4 softtabstop=4 tabstop=4 smarttab
sil! set backspace=2 nowrap textwidth=0 foldcolumn=0 nofoldenable foldignore=
sil! set foldlevelstart=99 foldmethod=indent foldnestmax=1 autoread mouse=a
sil! set hidden modeline

" Insert completion
sil! set completeopt=longest,menuone complete=.,w,b,u,t,i,d infercase
sil! set pumheight=14 shortmess+=c

" Command line
sil! set wildmenu wildchar=<TAB> wildignorecase cedit=<C-K>
if has("win32") | sil! set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\* |
  \ else | sil! set wildignore+=*/.git/*,*/.hg/*,*/.svn/* | endif

" Performance
sil! set lazyredraw ttyfast updatetime=300
sil! set timeout timeoutlen=500 ttimeout ttimeoutlen=100

" Search
sil! set hlsearch incsearch wrapscan ignorecase smartcase magic

" Colorscheme
if has('gui_running')
  let g:use_Xresources = 1 | colorscheme e7_hybrid
elseif &term == "rxvt-unicode-256color"
  let g:use_Xresources = 1 | colorscheme e7_hybrid
elseif stridx(&term, "256color") > 0
  let g:use_Xresources = 1 | colorscheme e7_bluez
else
 colorscheme base16-default
endif

" tmux compatibility
" in .tmux.conf -> set-window-option -g xterm-keys on
if &term =~ '^screen'
  execute "set <xUp>=\e[1;*A" | execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C" | execute "set <xLeft>=\e[1;*D"
endif

" File and syntax detection
filetype on
filetype plugin indent on
syntax on
syntax sync minlines=512
set synmaxcol=512


"}}}
" Mappings :help key-notation  {{{
" -----------------------------------------------------------------------------

" Fixes linux control console keys
" "od -a" and get the code
" "^[" is <ESC> at vim
map <ESC>Ob <C-Down>
map <ESC>Oc <C-Right>
map <ESC>Od <C-Left>
map <ESC>Oa <C-Up>
map <C-@> <C-Space>
map! <ESC>Ob <C-Down>
map! <ESC>Oc <C-Right>
map! <ESC>Od <C-Left>
map! <ESC>Oa <C-Up>
map! <C-@> <C-Space>

" Map leader
let mapleader = ','

" Ctrl +
" ···············································
" [C-Space] Autocomplete
inoremap <C-F> <C-X><C-F>
inoremap <expr> <C-Space> pumvisible()
      \ ? '<C-n>' : '<C-n><C-r>=pumvisible()
      \ ? "\<lt>Down>" : ""<CR>'

" [C-N] multiple cursors plugin (help vim-multiple-cursors)
" [C-M] multiple cursors plugin (help vim-multiple-cursors)
" [C-P] CtrlP

" Alt +
" ···············································
" Buffer movemenet with [Alt + arrow keys]
nnoremap <M-Right> :bn<CR>
nnoremap <M-Left> :bp<CR>
nnoremap <M-Up> :b#<CR>

" Keys alone
" ···············································
" [TAB] Next window
nnoremap <tab> <C-W>w
" [+] Increment number
nnoremap + <C-a>
" [-] Decrement number
nnoremap - <C-x>
" [<] Decrement indent on selecion
vnoremap < <gv
" [>] Increment indent on selecion
vnoremap > >gv
" [i] Auto indent on selecion
vnoremap i ==
" [ga] vim-easy-plugin
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" [gt] Goto TAG (vim help)
nnoremap gt <C-]>

" leader + chars (:h map-comments)
" ···············································
" [,] Toggle hlsearh
nnoremap <leader><leader> :nohlsearch<CR>
" [.] Format paragraph
nnoremap <leader>. gwip
" [a] Increment number in new line
nnoremap <leader>a  qaYp<C-A>q1@a
" [c] Increment vim size to vertical split
nnoremap <leader>c :set columns=174<CR>
" [d] Diff in vertical split
nnoremap <leader>d :vertical diffsplit<CR>
" [g {npud}] Move to git changes (gitgutter)
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gd <Plug>(GitGutterPreviewHunk)
" [ju] Join prev line at end (for comments)
nnoremap <leader>ju :m-2<CR>:join<CR>
" [r] Prepare replace with current word
nnoremap <leader>r :%s/<C-r><C-w>//gic
" [v] Vertical split
nnoremap <leader>v :vsplit<CR>
" [vm] Make vertical split same size
nnoremap <leader>vm :wincmd =<CR>
" [vi] Edit current .vimrc
nnoremap <leader>vi :call VimConfig()<CR>
" [vr] Reload vim config
nnoremap <leader>vr :call VimSource()<CR>
" [w] Delete trailing spaces/tabs
nnoremap <silent> <leader>w :%s/\s\+$\\| \+\ze\t//ge<CR>
" [x] Close current buffer without close panel (bufkill)
nnoremap <leader>x :BD<CR>

" Function keys
" ···············································
" [F2] Multiple cursor select all
" [F5] Run compilers
nnoremap <silent> <F5> :call ExecCompiler()<CR>
" [F9] Show Tags
noremap <F9> :TagbarToggle<CR>
" [F10] Show File explorer
noremap <F10> :NERDTreeFind<CR>
" [F11] Buffer explorer
noremap <F11> :CtrlPBuffer<CR>

"}}}
" Abreviations {{{
" -----------------------------------------------------------------------------

" Time
iab _datetime <C-R>=strftime("%a %b %d %T %Z %Y")<CR>
iab _time <C-R>=strftime("%H:%M")<CR>
iab _date <C-R>=strftime("%d %b %Y")<CR>

" Personal
iab _name Vicente Gimeno Morales
iab _mail vgimeno@tunelia.com

" HOME
iab _home ~/

"}}}
" Plugin Settings {{{
" -----------------------------------------------------------------------------

" Lightline (:help lightline.
let g:lightline = { 'colorscheme': g:colors_name }
let g:lightline.component_function = {
  \'gitbranch' : 'fugitive#head'}
let g:lightline.component_expand = {
  \ 'buffers' : 'lightline#bufferline#buffers',
  \ 'trailing' : 'TrailingLine' }
let g:lightline.component_type  = {
  \ 'buffers': 'tabsel',
  \ 'trailing': 'error' }
let g:lightline.active = {
  \ 'right': [ [ 'lineinfo' ],
  \            [ 'percent' ],
  \            [ 'trailing' ],
  \            [ 'fileformat', 'fileencoding', 'filetype', 'gitbranch' ] ] }
let g:lightline.tabline = {'left': [['buffers']], 'right': [['relativepath']]}

" Lightline bufferlist (tabline)
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#modified = ''
let g:lightline#bufferline#read_only = ''

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" TagBar
let g:tagbar_show_linenumbers = 1
let g:tagbar_left = 1

" BufExplorer
let g:bufExplorerShowRelativePath=1

" GitGutter
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = '▌'
let g:gitgutter_sign_modified = '▌'
let g:gitgutter_sign_removed = '▌'
let g:gitgutter_sign_removed_first_line = '▌'
let g:gitgutter_sign_modified_removed = '▌'

" Multiple cursos keymap redefine
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<F2>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Indent Line
let g:indentLine_setColors = 0
let g:indentLine_char = '┃'

" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_window = 'bottom,order:ttd,min:20,max:20,results:20'
let g:ctrlp_line_prefix = '● '

" Indent Line
let g:indentLine_setConceal = 0

"}}}
" Autocommands {{{
" -----------------------------------------------------------------------------

" Setting lazyredraw causes a problem on startup
au VimEnter * redraw

" Always open read-only when a swap file is found
au SwapExists * let v:swapchoice = 'o'

" Indent rules
au FileType c
  \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
au FileType markdown
  \ setlocal textwidth=78 sw=2 st=2 ts=2
au FileType prg
  \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 cindent

" Txt
au FileType text,changelog,help
  \ setlocal textwidth=78 wrap expandtab sw=2 ts=2 st=2

" Set correct markdown extensions
au BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
  \ if &ft =~# '^\%(conf\|modula2\)$' |
  \   set ft=markdown |
  \ else |
  \   setf markdown |
  \ endif

" Set filetype for prg
au BufNewFile,BufRead *.prg,*.dev,*.act,*.cas set ft=prg

" Mark chars exceding column 80
au BufWinEnter *
  \ call matchadd('ColorColumn', '\%81v', 100)

" Update lightline trailing section after file save
au CursorHold,BufWritePost * call MyLightLineUpdate()

"}}}
" My functions {{{
" -----------------------------------------------------------------------------

" Open and reload vimrc
if !exists ('*VimConfig')
  function! VimConfig()
    if has("win32")
      :e $HOME/_vimrc
    else
      :e $HOME/.vimrc
    endif
  endfunction
endif

" Reload vimrc
if !exists ('*VimSource')
  function! VimSource()
    if has("win32")
      :source $HOME/_vimrc
    else
      :source $HOME/.vimrc
    endif
  endfunction
endif

" Open compiler for filetype
function! ExecCompiler()
  " Autom
  if &ft == "prg"
    let l:path = expand('%:p:h')
    let l:file = expand('%:p')

    " Instalación competa de Jarvis/Siga
    if filereadable(l:path . "/jarvis.prg")
      let l:file=l:path . "/jarvis.prg"
    elseif filereadable(l:path . "/siga.prg")
      let l:file=l:path . "/siga.prg"
    endif

    " Win32 >  wsl / gvim
    if strlen($WSL_DISTRO_NAME) > 0
      let l:file = substitute(l:file, "/mnt/d", "d:", "g")
      :silent exe "!jarvis_w32.exe" l:file "&"
      :redraw!
    elseif has("win32")
      :silent exe "!jarvis_w32.exe" l:file
      :redraw!
      " Linux
    else
      :silent exe "!jarvis " l:file "&"
      :redraw!
    endif
  endif
endfunction

" Return fist line number with trailing space
function! TrailingLine()
  let l:n = search('\s$', 'nw')
  return l:n != 0 ? ( '● ' .l:n) : ''
endfunction

" My function for update lightline
function! MyLightLineUpdate()
  if get(b:, 'lightline_changedtick', 0) == b:changedtick
    return
  endif
  unlet! b:lightline_changedtick
  call lightline#update()
  let b:lightline_changedtick = b:changedtick
endfunction

"}}}

" vim:expandtab:ts=2:sw=2:sts=2:fdm=marker
