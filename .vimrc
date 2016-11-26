set nocompatible
syntax on
colorscheme peachpuff
filetype plugin on
set history=5000
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

function! DoTicket()
  for lineno in range(a:firstline, a:lastline)
    let line = getline(lineno)
    let line = substitute( line, '\s\+\(open\|onhold\|closed\|resolved\|needsinfo\)\s\+\(Support\|Reports\|Development\|Systems\|Bugs\|Migrations\).*', '', 'e' )
    let line = substitute( line, '\s\+\(Support\|Reports\|Development\|Systems\|Bugs\|Migrations\)\s\+\(open\|onhold\|closed\|resolved\|needsinfo\).*', '', 'e' )
    let line = substitute( line, '\d\+\s\+\(weeks\|hours\|days\)\s\+\(ago\s\+\)*', ' -- ', 'e' )
    let line = substitute( line, '^#*\(\<[0-9]\+\>\)[^ ]*[ ]\+', 'ticket \1 | UPDATED | ', 'e' )
    call setline(lineno, line)
  endfor
endfunction
command! -range Ticket <line1>,<line2>call DoTicket()

function! DoDayNote()
    %call DoTicket()
    g/^#\s\+Subject/d
    g/^Ticket\s\+Reminder/d
    g/ï/d
    g/Â/d
    %s/^My/My/
    %s/\n -- / -- /
    g/^Barton Support Dashboard$/d
    g/^Basics$/d
    g/^Content$/d
    g/^Subscription$/d
    g/^Show$/d
    g/^Search\.\.\.$/d
endfunction
command! Daynote call DoDayNote()


