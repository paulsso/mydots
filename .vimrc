set exrc
set secure
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=110
set number

highlight ColorColumn ctermbg=lightblue
syntax on

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
" set cursorcolumn

augroup project
    autocmd!
    autocmd BufRead,BufNewfile *.h,*.c,*.cpp set filetype=c.doxygen
augroup END

" uncomment to make comments green (fix for black background)
":highlight Comment ctermfg=green
