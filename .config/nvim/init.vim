"--- PLUGINS ---

    call plug#begin('~/.vim/plugged')

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }

    " File system explorer
    Plug 'preservim/nerdtree'

    " Theme
    Plug 'morhetz/gruvbox'

    " Statusbar
    Plug 'vim-airline/vim-airline'

    " Latex
    Plug 'lervag/vimtex'

    " Fuzzy finder for vim
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

    " Zen-Mode: type :Goyo
    Plug 'junegunn/goyo.vim'

    " Dims paragraphs, autom. activated by functions GoyoEnter/GoyoLeave below
    Plug 'junegunn/limelight.vim'

    " FZF for vim
    Plug 'junegunn/fzf.vim'

    " Arduino compiler/uploader/debugger
    Plug 'stevearc/vim-arduino'

    call plug#end()

" --- MAPPINGS ---

    " Leader key remap to spacebar
    let mapleader = ' '
    let maplocalleader = ' '
    nnoremap <SPACE> <Nop>

    " Open/close NerdTree in normal mode
    nmap <F9> :NERDTreeToggle<CR>

    " Inserting new lines in normal mode without entering insert mode
    nnoremap o o<Esc>
    nnoremap O O<Esc>

    " Leave insert mode by pressing jj
    inoremap jj <Esc>

    " Incrementing/decrementing numbers with Alt+a/x
    nnoremap <A-a> <C-a>
    nnoremap <A-x> <C-x>

    " Save file
    inoremap <C-s> <C-O>:update<CR>
    nnoremap <C-s> :update<CR>

    " Whitespace-removal
    inoremap <C-M-s> <C-O>:call <SID>StripTrailingWhitespaces()<CR>
    nnoremap <C-M-s> :call <SID>StripTrailingWhitespaces()<CR>

    " Make Y behave like other capitals
    nnoremap Y y$

    " qq to record, Q to replay
    nnoremap Q @q

    " Movement in insert mode
    inoremap <C-h> <C-O>h
    inoremap <C-k> <C-O>k
    inoremap <C-j> <C-O>j
    inoremap <C-l> <C-O>l

    " Copy to system clipboard
    nnoremap <silent> gy "+y
    xnoremap <silent> gy "+y
    nnoremap <silent> gY "+Y
    xnoremap <silent> gY "+Y
    nnoremap <silent> gp "+p
    xnoremap <silent> gp "+p
    nnoremap <silent> gP "+P
    xnoremap <silent> gP "+P

    " fzf.vim
    nnoremap <silent> <leader>f :Files<CR>
    nnoremap <silent> <leader>b :Buffers<CR>
    nnoremap <silent> <leader>w :Windows<CR>
    nnoremap <silent> <leader>t :Tags<CR>
    nnoremap <silent> <leader>o :History<CR>
    nnoremap <silent> <leader>: :History:<CR>
    nnoremap <silent> <leader>/ :History/<CR>

    " DiffOrig and closing
    nnoremap <leader>do :DiffOrig<cr>
    nnoremap <leader>dc <C-W>W:q<cr>

    " View Latex Table of Contents
    nnoremap <F8> :VimtexTocToggle<cr>

    " Mapping selecting mappings
    nmap <leader><tab> <plug>(fzf-maps-n)

    " Insert mode completion of dictionary words (can help with spelling)
    imap <c-w> <plug>(fzf-complete-word)

    " Folding via Tabulator
    nnoremap <tab> za

" --- VISUAL SETTINGS ---

    " Set colorscheme after starting up vim
    autocmd vimenter * colorscheme gruvbox

    set guifont=monospace

    " keep 6 lines when scrolling
    set scrolloff=6

    " show line numbers
    set number

    " show the current row and column
    set ruler

    " highlight searches
    set hlsearch

    " display incomplete commands
    set showcmd

    " don't display mode as we have vim-airline to show it
    set noshowmode

    " turn syntax highlighting on
    syntax on

    " Set a visual border so we can see where to break lines
    set colorcolumn=80
    highlight ColorColumn ctermbg=darkgrey

    " Cursor on same column
    set nostartofline

    " Highlight whitespaces and TODO/FIXME/XXX Tags in red
    match Todo /\s\+$/
    autocmd vimenter * highlight Todo cterm=bold ctermbg=1


" --- OTHER SETTINGS ---

    " enable mouse in normal mode
    set mouse=n

    " do incremental searching
    set incsearch

    " jump to matches when entering regexp
    set showmatch

    " ignore case when searching
    set ignorecase

    " no ignorecase if uppercase char present
    set smartcase

    " make that backspace key work the way it should (i.e. not treating 4 spaces
    " as a tab)
    " set backspace=indent,eol,start

    " Undo history saved in files, no backup, no swap
    set undodir=~/.vim/undodir
    set undofile
    set nobackup
    set noswapfile

    " detect type of file
    filetype on

    " set auto-indenting on
    set ai

    " load indent file for specific file type
    filetype indent on

    " Set general indentation
    set expandtab
    set shiftwidth=4
    set tabstop=4 softtabstop=4

    " Different indentation for different filetypes
    " Add customized rules at ~/.config/nvim/after/ftplugin/ as {$language}.vim,
    " such as python.vim or html.vim
    filetype plugin on

    " Treats .tex files as tex and not plaintext
    let g:tex_flavor = 'latex'

    " TeX viewer
    let g:vimtex_view_general_viewer = 'okular'
    let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
    let g:vimtex_view_general_options_latexmk = '--unique'

    " Spellchecking for german as well (in latex documents)
    set spelllang=en,de

    " The color limelight uses for dimming
    let g:limelight_conceal_ctermfg = 'gray'

" --- FUNCTIONS/COMMANDS ---

    " Function that removes Whitespaces and returns the Cursor to its original
    " position afterwards
    fun! <SID>StripTrailingWhitespaces()
        let l = line(".")
        let c = col(".")
        keepp %s/\s\+$//e
        call cursor(l, c)
    endfun

    " Use rg instead of grep
    " set grepprg=rg\ --vimgrep\ --smart-case\ --follow

    command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
    		\ | diffthis | wincmd p | diffthis

    " Plugin Goyo customizations: do not show tmux-statusbar
    function! s:goyo_enter()
      if executable('tmux') && strlen($TMUX)
        silent !tmux set status off
        silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
      endif
      set noshowcmd
      Limelight
    endfunction

    function! s:goyo_leave()
      if executable('tmux') && strlen($TMUX)
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
      endif
      set showcmd
      Limelight!
    endfunction

    autocmd! User GoyoEnter call s:goyo_enter()
    autocmd! User GoyoLeave call s:goyo_leave()

" my_file.ino [arduino:avr:uno] [arduino:usbtinyisp] (/dev/ttyACM0:9600)
function! MyStatusLine()
  let port = arduino#GetPort()
  let line = '%f [' . g:arduino_board . '] [' . g:arduino_programmer . ']'
  if !empty(port)
    let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
  endif
  return line
endfunction
autocmd BufNewFile,BufRead *.ino let g:airline_section_x='%{MyStatusLine()}'
