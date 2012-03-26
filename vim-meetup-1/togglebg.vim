function! TabToggle()
  " &option means to get an options current value
  " =~ is getting regex equality, !~ is the inverse value
  if &guioptions !~ 'e'
    set guioptions += e
  else
    set guioptions -= e
  endif
endfunction
 
command! -nargs=0 TabToggle :call TabToggle()
nnoremap <Leader>bg :TabToggle<CR>


" open grep at the top of the window
" requires regex to be surrounded in double-quotes
command! -complete=file -nargs=* Grep :exec 'grep <args>' | copen | wincmd K


" sort css styles alphabetically in a visual selection
autocmd FileType css,scss,sass xnoremap <buffer> <Leader>s :sort<CR>


" load the diff of the cached index in a new vertical buffer
" read! means to read from the output of a shell command
command! -nargs=0 Gcached vnew | exec "read!git diff --cached" | set ft=git


" or make it logical
function! GitCached()
  let diff = system('git diff --cached')

  if empty(diff) " if the diff is blank / nothing in the stage
    echomsg "Nothing in the stage."
  else
    vnew
    " create a single item list with all <NL> chars removed
    let sepdiff = split(diff, "<NL>")
    " create a list for each entry with a typed newline
    let sepdiff = split(sepdiff[0], "\n")

    call setline('.', sepdiff)
    set ft=git
  endif
endfunction

command! -nargs=0 Gcached :call GitCached()


" this is just emulating textmate's ;
autocmd FileType css,javascript inoremap <buffer> <expr> ;
      \ getline('.')[col('.')-1] == ';' ? "\<Right>" : ";"
