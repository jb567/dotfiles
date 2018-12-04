" View all registers
function! utility#reg()
  reg
  echo 'Register: '
  let char = nr2char(getchar())
  if char !=? "\<Esc>"
    execute 'normal! "' . char . 'p'
  endif
  redraw
endfunction

"Cleans written buffers
function! utility#wipeout()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  let wiped = 0
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1 && !getbufvar(v:val,"&mod")')
    silent execute 'bwipeout!' buf
    let wiped += 1
  endfor
  echom wiped . ' buffers wiped'
endfunction
