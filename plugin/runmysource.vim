" File:        runmysource.vim
" Description: Execute code with runmysource
" Author:      Diego Rubin <rubin.diego@gmail.com>
" Licence:     GPL v2
" Version:     0.0.1

if exists('g:loaded_vimrunmysource') || &cp
  finish
endif
let g:loaded_vimrunmysource = 1

let s:save_cpo = &cpo
set cpo&vim

" Options
if !exists('g:vimrunmysource_keymap')
  let g:vimrunmysource_keymap = 1
endif

function! s:RunMySource(...)

  if a:0 == 0
    echom "Needs a language"
    return
  endif

  let l:language = a:1

  if !exists('g:runmysource_input')
    let l:runmysource_input = ''
  else
    let l:runmysource_input = substitute(system("cat " . g:runmysource_input), '"', '\\"', 'g')
  endif

  if !exists('g:vimrunmysource_key')
    echom "You need to set the variable g:vimrunmysourcekey"
  else
    let l:source = substitute(join(getline(1,'$'), "\n"), '"', '\\"', 'g')
    let l:curl_command = 'curl -s -X POST http://executor.runmysource.com/ --data-urlencode "key=' . g:vimrunmysource_key . '"' . ' --data-urlencode "source=' . l:source . '" --data-urlencode "language=' . l:language . '" --data-urlencode "input=' . l:runmysource_input . '"'

    let l:result = split(system(l:curl_command), "\n")
    cexpr l:result
    copen

  endif

endfunction

function! s:RunMySourceInput()
  let g:runmysource_input = @%
  echom g:runmysource_input
endfunction

command! -nargs=* RunMySource :execute s:RunMySource(<f-args>)
command! RunMySourceInput :execute s:RunMySourceInput()

let &cpo = s:save_cpo

