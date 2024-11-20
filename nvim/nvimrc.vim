" Encoding
scriptencoding utf-8

" Text highlighting
filetype indent plugin on
syntax on

""""""""""""""""
" Command maps "
""""""""""""""""

" Set ctrl+c/v/x bindings
vmap <C-c>  "+yi
vmap <C-x>  "+c
vmap <C-v>  c<ESC>"+p
imap <C-v>  <C-r><C-o>+

" Select word under cursor (doesn't properly work)
"nnoremap <C-w>      viw
" Delete word under cursor
nnoremap <A-w>      diw
nnoremap <C-a>      ggVG
" Highlight all search occurances
nnoremap <F4>       :set hlsearch!<CR>

" move cursor with the line (sync scrolling)
nnoremap <C-S-E> j<C-E>
nnoremap <C-S-Y> k<C-Y>

" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

" Save and quit
command! W w
command! Q q
command! Wq wq
command! Wa wa
command! WQ wq

"""""""
" Let "
"""""""

" Use a line cursor within insert mode and a block cursor everywhere else
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"

" Set space key as <leader> key
let mapleader=" "

"""""""""""""
" Autogroup "
"""""""""""""

" reset the cursor on start
augroup myCmds
    au!
    autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

"""""""""""""
" Functions "
"""""""""""""

" Text formating (removing empty space at the EOL)
function! TrimWhitespace()
    let l:view = winsaveview()
    silent! %s/\s\+$//e
    silent! %s/\($\n\s*\)\+\%$//e
    call winrestview(l:view)
endfunction

" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
    " Save the last search.
    let search = @/

    " Save the current cursor position.
    let cursor_position = getpos('.')

    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)

    " Execute the command.
    execute a:command

    " Restore the last search.
    let @/ = search

    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt

    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

autocmd BufWritePre * :call TrimWhitespace()

""""""""""""
" Commands "
""""""""""""

" Copy current file path to the buffer
command! CopyFilePath let @+ = expand('%:p')

cnoreabbrev W w

""""""""
" Sets "
""""""""

" Each line have it's index
set nu
set rnu
" Now empty spaces are highlighting with symbol
set list
set cursorline
set hlsearch

" Mouse now active
set mouse=a

" Vim command line tab autocompletion
set nocompatible

" Set tabulation char count == 4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Display cursor pos info in the bottom right corner
set ruler
set rulerformat=%l::%v

" Make backspace great again
set backspace=indent,eol,start

" Search with '/' now cant be ended
set wrapscan

" Remove delay between modes switch
set ttimeout
set ttimeoutlen=1
set ttyfast

" Make vim use general clipboard
set clipboard=unnamedplus
set whichwrap+=h,l

" Wayland clipboard
xnoremap <silent> <leader>y y:call system("wl-copy --trim-newline", @*)<cr>:call system("wl-copy -p --trim-newline", @*)<cr>


""""""""""""""
" Highlights "
""""""""""""""

" tranparent bg
hi Normal guibg=NONE ctermbg=NONE

hi ColorColumn                      ctermbg=red         ctermfg=black
" italic comments
hi Comment      cterm=italic
hi CursorLine   cterm=bold          ctermbg=NONE        ctermfg=NONE
hi CursorLineNr cterm=bold          ctermbg=NONE        ctermfg=NONE
hi DiffAdd      cterm=bold          ctermbg=blue        ctermfg=black
hi DiffChange   cterm=bold          ctermbg=225         ctermfg=black
hi DiffDelete   cterm=bold          ctermbg=159         ctermfg=black
hi Error                            ctermbg=red         ctermfg=black
hi ErrorMsg                         ctermbg=red         ctermfg=black
hi LineNr                                               ctermfg=darkblue
hi Search       cterm=bold          ctermbg=yellow      ctermfg=black
hi SignColumn   cterm=standout      ctermbg=white       ctermfg=black
hi SpellBad     cterm=underline     ctermbg=NONE        ctermfg=red
hi SpellLocal   cterm=reverse       ctermbg=black
hi SpellCap     cterm=bold          ctermbg=NONE        ctermfg=blue
hi SpellRare    cterm=reverse       ctermbg=darkblue
" Suggestion menu
hi Pmenu                            ctermbg=0           ctermfg=15
" Brackets match
hi MatchParen   cterm=bold          ctermbg=black       ctermfg=white
hi link         YcmWarningText      SpellCap
