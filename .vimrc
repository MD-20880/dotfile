call plug#begin()

Plug 'dense-analysis/ale'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'

call plug#end()

" Set tab as 4 spaces
set tabstop=4
"Set auto shift
set shiftwidth=4

"Set tab as space
set expandtab
let g:ale_completion_enabled = 1
