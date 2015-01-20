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
syn keyword prgOperator         msg_t msg
syn keyword prgPreProc          #driver #pragma
syn keyword prgConstant         autom stat
syn keyword prgIdentifier       every ontime when at
syn keyword prgType		fixed1 fixed2 fixed bitmask float
syn keyword prgFunction		validate remember name desc index enabled enable
syn keyword prgFunction		disable log warning trace 
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
  HiLink prgOperator            Operator
  HiLink prgConstant            Constant
  HiLink prgIdentifier          Identifier
  HiLink prgStatement           Statement
  HiLink prgFunction		Function
  HiLink prgType		Type
  HiLink prgStorageClass	StorageClass
  HiLink prgStructure		Structure
  HiLink prgBoolean		Boolean
  HiLink prgPreProc		PreProc
  delcommand HiLink
endif

let b:current_syntax = "prg"

" vim: ts=8
