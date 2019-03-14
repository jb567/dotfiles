scriptencoding utf-8

function! s:isloc()
    let wininfo = filter(wininfo(), {i,v -> v.winnr == winnr()})[0]
    return wininfo.loclist
endfunction

function! jb567#qf#length()
    return len(s:isloc() ? getloclist(0) : getqflist())
endfunction

function! s:getProperty(key, ...)
  " getqflist() and getloclist() expect a dictionary argument.
  " If a 2nd argument has been passed in, use it as the value, else 0
  let l:what = {a:key : a:0 ? a:1 : 0}
  let l:listdict = s:isloc() ? getloclist(0, l:what) : getqflist(l:what)
  return get(l:listdict, a:key)
endfunction

function! s:isFirst()
  return s:getProperty('nr') <= 1
endfunction

function! s:isLast()
  return s:getProperty('nr') == s:getProperty('nr', '$')
endfunction

function! s:history(goNewer)
  " Build the command: one of colder/cnewer/lolder/lnewer
  let l:cmd = (s:isloc() ? 'l' : 'c') . (a:goNewer ? 'newer' : 'older')

  " Apply the cmd repeatedly until we hit a non-empty list, or first/last list
  " is reached
  while 1
    if (a:goNewer && s:isLast()) || (!a:goNewer && s:isFirst()) | break | endif
    " Run the command. Use :silent to suppress message-history output.
    " Note that the :try wrapper is no longer necessary
    silent execute l:cmd
    if jb567#qf#length() | break | endif
  endwhile

  " Set the height of the quickfix window to the size of the list, max-height 10
  execute 'resize' min([ 10, max([ 1, jb567#qf#length() ]) ])
endfunction

function! jb567#qf#older()
  call s:history(0)
endfunction

function! jb567#qf#newer()
  call s:history(1)
endfunction
