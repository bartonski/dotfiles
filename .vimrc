syntax on
colorscheme peachpuff
filetype plugin on
set updatetime=250
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"

" tab settings
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4

set background=dark
set ls=2

:set pt=<f9>
" Toggle windows with F5
nnoremap <F5> <C-W><C-W>
nnoremap <F7> [czz
nnoremap <F8> ]czz
" Diffput with F3
nnoremap <F3> dp
" Toggle relative line numbering with F2
nnoremap <F2> :set relativenumber!<CR>
" Control-U => upper case word.
nnoremap <c-u> viwU
" Search for '^ [0-9]' with F4
nnoremap <F4> /^ [0-9]<CR>
:
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

" Load matchit (% to bounce from do to end, etc.)
  runtime! macros/matchit.vim

  augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
  augroup END


if filereadable( $HOME . "/.vim/autoload/pathogen.vim" )
    execute pathogen#infect()
endif

function! DoDayNote()
    %s/\s\+\(open\|onhold\|closed\|resolved\)\s\+\(Support\|Reports\|Development\|Systems\|Bugs\).*//
    %s/\n\d\+\s\+\(weeks\|hours\|days\)\s\+\(ago\s\+\)*/ -- /
    g/^#\s\+Subject/d
    g/^Ticket\s\+Reminder/d
    %s/^My/My/
    %s/^#*\(\<[0-9]\+\>\)[^ ]*[ ]\+/ticket \1 | UPDATED | /
endfunction
command! Daynote call DoDayNote()
