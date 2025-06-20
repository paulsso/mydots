#!/bin/bash

set -e

NVIM_CONFIG_DIR="$HOME/.config/nvim"
INIT_FILE="$NVIM_CONFIG_DIR/init.vim"

# Ensure config directory exists
mkdir -p "$NVIM_CONFIG_DIR"

# Write basic config with language-specific tab settings
cat > "$INIT_FILE" <<EOF
" General settings
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set noexpandtab
set autoindent
set smartindent
set mouse=a
syntax on
filetype plugin indent on

" Python settings
augroup python_settings
  autocmd!
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 noexpandtab
augroup END

" C/C++/Headers settings
augroup c_cpp_settings
  autocmd!
  autocmd FileType c,cpp,cxx,h,hpp,hxx setlocal tabstop=4 shiftwidth=4 noexpandtab
augroup END

" YAML and similar settings
augroup yaml_settings
  autocmd!
  autocmd FileType yaml,yml,oml setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

" Visual mode keybindings
vnoremap <C-Right> $
vnoremap <C-Left> 0

" Python integration for Neovim
let g:python3_host_prog = expand("~/.venvs/default/bin/python")

EOF

echo "nvim configuration written to $INIT_FILE."

