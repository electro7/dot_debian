" ~/.vimrc
"
" Archivo de configuración del editor VIM (er mejo!)
"
" Trato que funcione tanto en WIN (con gvim) como en LINUX (vim y gvim)
" Configuración ontenida de W0ng -> https://github.com/w0ng
"
" - linux -> ~/.vimrc
" - win -> $HOME/_vimrc
"
" Electro7 - Version 3.2 - 11 sep 2019
"==============================================================================
"
" Compability {{{
" -----------------------------------------------------------------------------
"
set nocompatible        " use vim defaults instead of vi
set encoding=utf-8      " always encode in utf

"}}}
" Vim Plugins {{{
" -----------------------------------------------------------------------------
"
" Brief help
" :PluginList           - lists configured plugins
" :PluginInstall        - installs plugins
" :PluginUpdate         - Update Plugins
" :PluginSearch foo     - searches for foo; append `!` to refresh local cache
" :PluginClean          - confirms removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"Put your non-Plugin stuff after this line
"Plugin 'Shougo/neocomplete'                " Automatic keyword completion
"Plugin 'Shougo/unite.vim'                  " Find files and buffers using ag
"Plugin 'Shougo/vimfiler.vim'               " File Explorer :VimFiler
Plugin 'scrooloose/nerdtree'                " File Explorer
Plugin 'jlanzarotta/bufexplorer'            " Buffer Explorer :BufExplore
Plugin 'godlygeek/tabular'                  " Text alignment
Plugin 'majutsushi/tagbar'                  " Display tags in a window
"Plugin 'scrooloose/syntastic'              "  checking on write
Plugin 'tpope/vim-fugitive'                 " Git wrapper
Plugin 'airblade/vim-gitgutter'             " Show git diffs
Plugin 'tpope/vim-surround'                 " Manipulate quotes and brackets
Plugin 'bling/vim-airline'                  " Pretty statusbar
Plugin 'terryma/vim-multiple-cursors'       " Multiple cursors work
Plugin 'edkolev/promptline.vim'             " Prompt generator for bash
Plugin 'plasticboy/vim-markdown'            " Markdown integration
Plugin 'christoomey/vim-tmux-navigator'     " Move easy between tmux and vim
Plugin 'tmux-plugins/vim-tmux-focus-events' " Best tmux+vim integration

" All of your Plugins must be added before the following line
call vundle#end()

if has("win32")
    set runtimepath+=~/.vim
endif

"}}}
" Settings {{{
" -----------------------------------------------------------------------------

" File detection
filetype on
filetype plugin indent on
syntax on
set synmaxcol=256
syntax sync minlines=512

" General
set backspace=2                     " enable <BS> for everything
set fillchars+=vert:┃               " separator for vsplit column
set colorcolumn=0                   " No column (using matchadd)
set number                          " Show line numbers
set cursorline                      " Color current line number
set completeopt=longest,menuone     " Autocompletion options
set complete=.,w,b,u,t,i,d          " autocomplete options (:help 'complete')
set hidden                          " hide when switching buffers, don't unload
set laststatus=2                    " always show status line
set lazyredraw                      " don't update screen when executing macros
set mouse=a                         " enable mouse in all modes
set noshowmode                      " don't show mode, using airline
set nowrap                          " disable word wrap
set showbreak="+++ "                " String to show with wrap lines
set number                          " show line numbers
set showcmd                         " show command on last line of screen
set showmatch                       " show bracket matches
set spelllang=es                    " spell
set spellfile=~/.vim/spell/es.utf-8.add
set textwidth=0                     " don't break lines after some maximum width
set ttyfast                         " increase chars sent to screen for redraw
"set ttyscroll=3                    " limit lines to scroll to speed up display
set title                           " use filename in window title
set wildmenu                        " enhanced cmd line completion
set wildchar=<TAB>                  " key for line completion
set noerrorbells                    " no error sound
set splitright                      " Split new buffer at right
set updatetime=1000                 " MS to update swap file
set conceallevel=2                  " Don't show conceal marks (:help conceal)
set concealcursor=ni                " Don't show conceal on line cursor
set noshowcmd                       " Don't show cmd: faster cursor

" Folding
set foldignore=                     " don't ignore anything when folding
set foldlevelstart=99               " no folds closed on open
set foldmethod=marker               " collapse code using markers
set foldnestmax=1                   " limit max folds for indent

" Tabs to spaces (use :retab in existing file)
set autoindent                      " copy indent from previous line
set expandtab                       " replace tabs with spaces
set shiftwidth=4                    " spaces for autoindenting
set smarttab                        " <BS> removes shiftwidth worth of spaces
set softtabstop=4                   " spaces for editing, e.g. <Tab> or <BS>
set tabstop=4                       " spaces for <Tab>
set list lcs=tab:+·                 " show tabs

" Searches
set hlsearch                        " highlight search results
set incsearch                       " search whilst typing
set ignorecase                      " case insensitive searching
set smartcase                       " override ignorecase if upper case typed
set more                            " Stop in list

" Status bar -> Replace with vim-airplane plugin
set laststatus=2                    " show ever
"set showmode                        " show mode
"set showcmd                         " show cmd
set ruler                           " show cursor line number
set shm=atI                         " cut large messages

" Colours
set t_Co=256
set background=dark
if has("win32")
    let g:use_Xresources = 1
    colorscheme e7_hybrid
elseif stridx(&term, "256color") > 0
    let g:use_Xresources = 1
     colorscheme e7_bluez
elseif stridx(&term, "rxvt") > 0
    let g:use_Xresources = 1
    colorscheme e7_hybrid
else
    colorscheme base16-default
endif

" gVim
if has('gui_running')
    if has("win32")
        set guifont=Consolas\ NF:h9
        set lines=60                            " Nº lines
        set columns=90                          " Nº columns
    else
        set guifont=Inconsolata\ for\ Powerline\ 10
    endif
    set guioptions-=m                           " remove menu
    set guioptions-=T                           " remove toolbar
    set guioptions-=r                           " remove right scrollbar
    set guioptions-=b                           " remove bottom scrollbar
    set guioptions-=L                           " remove left scrollbar
    set guicursor+=a:block-blinkon0             " use solid block cursor
endif

" vimdiff
if &diff
    set diffopt=filler,foldcolumn:0
endif

" tmux + ctrl + alt keys
" in .tmux.conf -> set-window-option -g xterm-keys on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"}}}
" Mappings :help key-notation  {{{
" -----------------------------------------------------------------------------

" Mapping timeour
set timeoutlen=500

" Fixes linux control console keys
" "od -a" and get the code
" "^[" is <ESC> at vim
map <ESC>Ob <C-Down>
map <ESC>Oc <C-Right>
map <ESC>Od <C-Left>
map <ESC>Oa <C-Up>
map <C-@> <C-Space>
map! <ESC>Ob <C-Down>
map!<ESC>Oc <C-Right>
map! <ESC>Od <C-Left>
map! <ESC>Oa <C-Up>
map! <C-@> <C-Space>

" Map leader
let mapleader = ','

" Ctrl +
" ·············································
" Autocomplete
inoremap <C-F> <C-X><C-F>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-Space> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" <C-N> -> multiple cursors plugin (help vim-multiple-cursors)
" <C-S-N> -> multiple cursors plugin (help vim-multiple-cursors)

" Alt +
" ···············································
nnoremap <M-Right> :bn<CR>|                      " Next buffer
nnoremap <M-Left> :bp<CR>|                       " Prev buffer
nnoremap <M-Up> :b#<CR>|                         " Last buffer

" Specials keys
" ···············································
nnoremap <tab> <C-W>w|                           " Next window

" leader + chars (:h map-comments)
" ···············································
nnoremap <leader><leader> :nohlsearch<CR>|       " Toggle hlsearh for results
nnoremap <leader>a  qaYp<C-A>q1@a|               " Increment on cursor in new line
nnoremap <leader>b :BufExplorer<CR>|             " Open buff explorer
nnoremap <leader>bn :bn<CR>|                     " Next Buffer
nnoremap <leader>bp :bp<CR>|                     " Prev Buffer
nnoremap <leader>c :set columns=174<CR>|         " Set columns to doble panel
nnoremap <leader>d :vertical diffsplit<CR>|      " Open diff vertical
nnoremap <leader>f za|                           " Toggle fold
nnoremap <leader>fo zR|                          " Open all folds
nnoremap <leader>fc zM|                          " Close all fods
nnoremap <leader>fr zO|                          " Open folds recursive
nnoremap <leader>fR zO|                          " Close folds recursive
nmap <leader>gn <Plug>(GitGutterNextHunk)|       " Next git change (gitgutter)
nmap <leader>gp <Plug>(GitGutterPrevHunk)|       " Prev git change (gitgutter)
nmap <leader>gu <Plug>(GitGutterUndoHunk)|       " Undo change (gitgutter)
nmap <leader>gd <Plug>(GitGutterPreviewHunk)|    " Diff change (gitgutter)
nnoremap <leader>i gg=G|                         " Indent file
nnoremap <leader>ju :m-2<CR>:join<CR>|           " Join line with prev at end
nnoremap <leader>r :%s/<C-r><C-w>//gic|          " Replace (:h substitute)
nnoremap <leader>to :set list lcs=tab:+·<CR>|    " Show tabs
nnoremap <leader>tc :set nolist<CR>|             " Don't show tabs
nnoremap <leader>ta :'<,'> Tabularize /|         " Prepare tabularize (:h tabular)
vnoremap <leader>ta :Tabularize /|               " Tabularize in visual mode
nnoremap <leader>v :vsplit<CR>|                  " Vertical split
nnoremap <leader>vm :wincmd =<CR>|               " Vertical split at 50%
nnoremap <leader>vi :call VimConfig()<CR>|       " Edit .vimrc/_vimrc
nnoremap <leader>vr :call VimSource()<CR>|       " Reload vim config
nnoremap <leader>w :%s/\s\+$\\| \+\ze\t//gc<CR>| " Delete trailing spaces
nnoremap <leader>x :BD<CR>|                      " Buffer deletion (buffkill)

" Chars as is
" ···············································
nnoremap gt <C-]>|                               " Goto TAG
"
" F Function keys
" ···············································
" F2 - Paste mode for terminal
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
": F3 - vimgrep (** para recursico. Ej ../**/*.prg)
:nnoremap <F3> :execute 'noautocmd lvim /'.expand('<cword>').'/j '.expand('%')
    \ <Bar> lw<CR>
nnoremap <C-F> :noautocmd lvim //j * <Bar> lw
" F5 - Run compiler
nnoremap <silent> <F5> :call ExecCompiler()<CR>
" F9 - Ctags Bar
noremap <F9> :TagbarToggle<CR>
" F10 - File Explorer
noremap <F10> :NERDTreeFind<CR>
" F11 - Buf Explorer
noremap <F11> :ToggleBufExplorer<CR>

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

" Heads
iab _ct -----------------------------------------------------------------------------<ESC>ki
iab _cp // --------------------------------------------------------------------------<ESC>ki
iab _cc /* <CR>*****************************************************************************/<ESC>ki
iab _cc1 /* <CR>----------------------------------------------------------------------------*/<ESC>ki

" HOME
iab _home ~/

"}}}
" Plugin Settings {{{
" -----------------------------------------------------------------------------
"  vim-airline
let g:airline_inactive_collapse = 0
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1            " Lista de buffers
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tagbar#enabled = 0
call airline#parts#define_accent('mode', 'none')        " Quita fuentes en bold
call airline#parts#define_accent('linenr', 'none')      " Quita fuentes en bold
call airline#parts#define_accent('maxlinenr', 'none')   " Quita fuentes en bold
let g:airline#extensions#hunks#enabled = 1              " Cambios de git
let g:airline#extensions#hunks#non_zero_only = 0
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme = 'e7_hybrid'
if stridx(&term, "256color") > 0
    let g:airline_theme = 'e7_bluez'
    let g:airline_powerline_fonts = 0
    let g:airline_powerline_ascii = 1
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ''
    let g:airline#extensions#tabline#right_sep = ''
    let g:airline#extensions#tabline#right_alt_sep = ''
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.linenr = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.whitespace = ''
elseif stridx(&term, "rxvt") > 0
    let g:airline_powerline_fonts = 1
elseif has('gui_running')
    let g:airline_powerline_fonts = 1
else
    let g:airline_powerline_ascii = 1
endif

" Promptline
let g:promptline_preset = {
    \'a': [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
    \'b': [ promptline#slices#user() ],
    \'c': [ promptline#slices#cwd() ],
    \'x': [ promptline#slices#vcs_branch() ],
    \'z': [ promptline#slices#git_status() ],
    \'warn' : [ promptline#slices#last_exit_code() ]}
let g:promptline_theme = 'e7_hybrid'

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
let g:gitgutter_sign_added = '●'
let g:gitgutter_sign_modified = '●'
let g:gitgutter_sign_removed = '●'
let g:gitgutter_sign_removed_first_line = '●'
let g:gitgutter_sign_modified_removed = '●'

" Multiple cursos keymap redefine
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<C-S-N>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"}}}
" Autocommands {{{
" -----------------------------------------------------------------------------

" Omnicompletion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown,xhtml setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Indent rules, Linux Kernel Coding Style
autocmd FileType c
    \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
    \ list lcs=tab:+·
autocmd FileType cpp,java,javascript,json,markdown,php,python
    \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
    \ list lcs=tab:+·
autocmd FileType markdown setlocal textwidth=80 sw=2 st=2 ts=2
autocmd FileType prg
    \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 cindent
    \ list lcs=tab:+·

" Txt
autocmd FileType text setlocal textwidth=79 wrap

" Folding rules
autocmd FileType c,cpp,java,prg
    \ setlocal foldmethod= foldnestmax=2 foldlevel=0

autocmd FileType css,html,htmldjango,xhtml
    \ setlocal foldmethod=indent foldnestmax=20 foldlevel=0

" Set correct markdown extensions
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
    \ if &ft =~# '^\%(conf\|modula2\)$' |
    \   set ft=markdown |
    \ else |
    \   setf markdown |
    \ endif

" Set filetype for prg
autocmd BufNewFile,BufRead *.prg,*.dev,*.act,*.cas set ft=prg

au BufWinEnter *
    \ call matchadd('ColorColumn', '\%81v', 100)     " mark char > column 80

"}}}
" Functions {{{
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

"}}}

" vim:expandtab:tabstop=4:shiftwidth=4:softtabstop=4:foldlevel=0
