" define a function, ! means redefine if previously defined
function! RemoveSpan()
  " loop over 5 times
  for i in range(0, 5)
    " create a new spans string if previously undefined
    if !exists('spans')
      let spans = ''
    endif
     
    " get the current line the cursor is on + the iteration
    let linenr   = line('.') + i

    " the text on the current iterated line
    let linetext = getline(linenr)

    " match the span tag and append to a string with .=
    let spans   .= matchstr(linetext, '<span>.*<\/span>')

    " make a string that has the span tag removed
    let replace  = substitute(linetext, '<span>.*<\/span>', '', '')

    " set the replacement into the current line
    call setline(linenr, replace)
  endfor

  " append a new line with the concatenated span block
  normal G
  call setline('.', spans)
endfunction


" you may notice that this just has all the spans in one line, to fix this:
" substitute(getline('.'), '<span>\ze', "<span>\r", 'g')
