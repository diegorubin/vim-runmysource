" File:        runmysource.vim
" Description: Execute code with runmysource
" Author:      Diego Rubin <rubin.diego@gmail.com>
" Licence:     GLPV2
" Version:     0.0.1

if exists('g:loaded_vimrunmysource') || &cp
  finish
endif
let g:loaded_vimrunmysource = 1

let s:save_cpo = &cpo
set cpo&vim

" Options
if !exists('g:vimrunmysource_key')
  let g:vimrunmysource_key = ''
endif

if !exists('g:vimrunmysource_keymap')
  let g:vimrunmysource_keymap = 1
endif

function! s:RunMySource()
  let l:filename = @%
endfunction

command! RunMySource :call <SID>RunMySource()

" Shortcuts for RunMySource
if g:vimrunmysource_keymap == 1
  nmap <Leader>rms :RunMySource<CR>
endif

let &cpo = s:save_cpo

