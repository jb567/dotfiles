augroup vimfiletype
    autocmd!
    autocmd BufNewFile,BufRead *.vim setfiletype vim
    autocmd BufNewFile,BufRead *vimrc setfiletype vim
augroup end
