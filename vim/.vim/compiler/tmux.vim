if exists('current_compiler')
  finish
endif
let current_compiler = 'tmux'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions-=C

CompilerSet makeprg=tmux\ source-file\ %:p

CompilerSet errorformat=
    \%f:%l:%m,
    \%+Gunknown\ command:\ %s

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
