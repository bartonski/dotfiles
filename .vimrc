set nocompatible

" =============== Display ===============
colorscheme peachpuff
set background=dark
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
" Unicode -- see https://stackoverflow.com/questions/5166652/how-to-view-utf-8-characters-in-vim-or-gvim
set enc=utf-8
syntax on

" =============== Behavior ===============
filetype plugin on
set history=5000
set updatetime=250
set scrolloff=10
" turn off pi_paren; disable brace match highlighting.
let loaded_matchparen = 1

" =============== tab settings ===============
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround

set ls=2

set pt=<f9>

" =============== Mappings ===============
" ALWAYS USE noremap, nnoremap, vnoremap, and inoremap

" move current line down with dash
noremap - ddp
" move current line up with underscore
noremap _ ddkP

" Control-U => upper case word.
nnoremap <c-u> viwU

" == F Keys ==
" Toggle relative line numbering with F2
nnoremap <F2> :set relativenumber!<CR>
" Diffput with F3
nnoremap <F3> dp
" Search for '^ [0-9]' with F4
nnoremap <F4> /^ [0-9]<CR>
" Toggle windows with F5
nnoremap <F5> <C-W><C-W>
" Next diff
nnoremap <F7> ]czz
" Prev diff
nnoremap <F8> [czz

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

function! DoFormatXML()
        %!xmllint --format -
endfunction
command! FormatXML call DoFormatXML()

"" Load matchit (% to bounce from do to end, etc.)
"  runtime! macros/matchit.vim

  augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
  augroup END


if filereadable( $HOME . "/.vim/autoload/pathogen.vim" )
    execute pathogen#infect()
endif
