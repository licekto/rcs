set number
set cindent
syntax on

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set list

set incsearch
set hlsearch

" IP address check
match ErrorMsg /\(2[5][6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)[.][0-9]\{1,3\}[.][0-9]\{1,3\}[.][0-9]\{1,3\}\|[0-9]\{1,3\}[.]\(2[5][6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)[.][0-9]\{1,3\}[.][0-9]\{1,3\}\|[0-9]\{1,3\}[.][0-9]\{1,3\}[.]\(2[5]\[6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)[.][0-9]\{1,3\}\|[0-9]\{1,3\}[.][0-9]\{1,3\}[.][0-9]\{1,3\}[.]\(2[5][6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)/

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]

set cursorline
highlight cursorline ctermbg=235 term=bold cterm=bold

let mapleader = '-' 
" Copy to x-clipboard
map <silent><Leader>xy :w !xsel -i -p<cr><cr>
" Paste from x-clipboard
map <silent><Leader>xp :r !xsel -p<cr>

nnoremap <leader><space> :nohlsearch<CR>
