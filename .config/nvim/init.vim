call plug#begin('~/.config/nvim/plugged')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'editorconfig/editorconfig-vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'arcticicestudio/nord-vim'
call plug#end()

syntax enable
colorscheme nord
hi Normal guibg=NONE ctermbg=NONE
