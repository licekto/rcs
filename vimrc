set number
set cindent
syntax on

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Show tabs as characters ^I
" set list

set incsearch
set hlsearch

" IP address check
match ErrorMsg /\(2[5][6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)[.][0-9]\{1,3\}[.][0-9]\{1,3\}[.][0-9]\{1,3\}\|[0-9]\{1,3\}[.]\(2[5][6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)[.][0-9]\{1,3\}[.][0-9]\{1,3\}\|[0-9]\{1,3\}[.][0-9]\{1,3\}[.]\(2[5]\[6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)[.][0-9]\{1,3\}\|[0-9]\{1,3\}[.][0-9]\{1,3\}[.][0-9]\{1,3\}[.]\(2[5][6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)/

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]

set cursorline
highlight cursorline ctermbg=235 term=bold cterm=bold
set showcmd

let mapleader="-"
" Copy to x-clipboard
vmap <silent><Leader>xy :w !xsel -i -b<cr><cr>
" Paste from x-clipboard
map <silent><Leader>xp :r !xsel -b<cr>

nnoremap <leader><space> :nohlsearch<CR>

" SpellCheck
" Documentation: http://vimdoc.sourceforge.net/htmldoc/spell.html
" Currently turned off
" set spell
set spelllang=en_us
set spellfile="en.utf-8.spl"
set spellcapcheck=
hi SpellBad ctermfg=white

" Navigate through wrapped lines
map <DOWN> gj
map <UP> gk
imap <DOWN> <ESC>gji
imap <UP> <ESC>gki

" Show changes made until the last save
function! DiffWithFileFromDisk()
    let filename=expand('%')
    let diffname = filename.'.fileFromBuffer'
    exec 'saveas! '.diffname
    diffthis
    vsplit
    exec 'edit '.filename
    diffthis
endfunction
nmap <F7> :call DiffWithFileFromDisk()<cr>
