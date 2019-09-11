" Vim syntax file
" Language:	PRG (Autómatas Cecom)
" Current Maintainer:	Vicente Gimeno
" Last Change:	16 ene 2015

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/c.vim
else
  runtime! syntax/c.vim
  unlet b:current_syntax
endif

" PRG keywords
syn keyword prgPreProc          #driver #pragma msg_t #dev #dup
syn keyword prgFunction         autom stat every ontime when at msg
syn keyword prgFunction         .cas .modbus .serial .ethraw .csnmp
syn keyword prgFunction         .action .autolink .jetio .lontcp .smodbus
syn keyword prgFunction         .share .timetab .varcli .varser .webser
syn keyword prgIdentifier       log warning trace rand error
syn keyword prgIdentifier	validate remember name desc index enabled enable
syn keyword prgIdentifier	enable disable setlength clearlength lenght
syn keyword prgIdentifier	beep hex dupindex dupstat shanswer loops
syn keyword prgIdentifier	keyboard diginp time date clock shutdown
syn keyword prgIdentifier	digout wday mday month year
syn keyword prgIdentifier	index number save stamp crc revert
syn keyword prgIdentifier	trap trapped debug module asoc strchr
syn keyword prgIdentifier	strchrfrom substr find findfrom
syn keyword prgIdentifier	dupindex dupstat
syn keyword prgType		fixed1 fixed2 fixed bitmask float time_t
syn keyword prgStorageClass	volatile persistent input output auto
syn keyword prgStructure	struct level
syn keyword prgBoolean		true false

" Default highlighting
if version >= 508 || !exists("did_prg_syntax_inits")
  if version < 508
    let did_prg_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink prgPreProc		PreProc
  HiLink prgFunction		Function
  HiLink prgIdentifier          Identifier
  HiLink prgType		Type
  HiLink prgStatement           Statement
  HiLink prgStorageClass	StorageClass
  HiLink prgStructure		Structure
  HiLink prgBoolean		Boolean
  delcommand HiLink
endif

let b:current_syntax = "prg"

" vim: ts=8
