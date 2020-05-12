""""""""""""""""""""""""""""""""""""""""""""""""""
" vim/neovim config file
""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-plug: Plugins section
call plug#begin('~/.config/nvim/plugged')

  " User Interface
  Plug 'https://github.com/lifepillar/vim-solarized8'       " Solarized color schema
  Plug 'https://github.com/machakann/vim-highlightedyank'   " Highlights in red the yanked text
    let g:highlightedyank_highlight_duration = 200
  Plug 'https://github.com/psliwka/vim-smoothie'            " Smoothie scroll (using [Ctrl-u], [Ctrl-d], [Ctrl-b] and [Ctrl-f]
  Plug 'https://github.com/gillyb/stable-windows'           " When opening splits, maintains the same layout (working?)
  Plug 'https://github.com/airblade/vim-gitgutter'          " Adds Git changes in lines

  " Fuzzy finder
  Plug '/usr/local/opt/fzf'                                 " Fuzzy finder in Vim
  Plug 'https://github.com/junegunn/fzf.vim'                " Extended Fuzzy finder commands

  " Intregration of Git
  Plug 'https://github.com/tpope/vim-fugitive'              " Best Git plugin for Vim
  Plug 'https://github.com/int3/vim-extradite'              " Git commit plugin for Vim

  " Text manupilation
  Plug 'https://github.com/tpope/vim-commentary'            " Better commenting lines
  Plug 'https://github.com/tpope/vim-surround'              " All about 'surroundings': parentheses, brackets, quotes, XML tags, and more
  Plug 'https://github.com/matze/vim-move'                  " Extends movement of text in the buffer
  Plug 'https://github.com/junegunn/vim-easy-align'         " Alignment for contiguos lines using a character as a reference
  Plug 'https://github.com/tpope/vim-repeat'                " Allows use of '.' in some plugins

  " Movement inside a buffer
  Plug 'https://github.com/Lokaltog/vim-easymotion'         " Improved movement and motion
  Plug 'https://github.com/chrisbra/matchit'                " Extended use for % command
  Plug 'https://github.com/justinmk/vim-sneak'              " Extended use for % command

  " Other
  Plug 'https://github.com/wellle/targets.vim'              " Adds text objects and improves the default ones
  Plug 'https://github.com/mbbill/undotree'                 " Shows undo tree for the current buffer
  Plug 'https://github.com/pbrisbin/vim-mkdir'              " Creates all required folders when saving buffers
  Plug 'https://github.com/xolox/vim-session'               " Improves Vim session management
  Plug 'https://github.com/chrisbra/Colorizer'              " Colorizes all color codes and color names in the buffer
  Plug 'https://github.com/xolox/vim-misc'                  " Misc Vim script functions (required for vim-session)
  Plug 'https://github.com/christoomey/vim-tmux-navigator'  " Seamless navigation between tmux panes and vim splits
  Plug 'https://github.com/tpope/vim-unimpaired'            " Mappings for common ex commands, line mappings (add before/after, movement), toggle vim options and encode/decode
  Plug 'https://github.com/bfredl/nvim-miniyank'            " Saves in disk yanked or deleted text so it will be shared between vim instances
  Plug 'https://github.com/vifm/vifm.vim'                   " Vim plugin that allows use of vifm as a file picker
  Plug 'https://github.com/mhinz/vim-grepper'               " Multiple kind of greps, populates quickfix or location list

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" Funcions
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Creates cache folders
:silent exec "!mkdir -p $HOME'/.cache/nvim/nvim_undo'"
:silent exec "!mkdir -p $HOME'/.cache/nvim/nvim_view'"
:silent exec "!mkdir -p $HOME'/.cache/nvim/nvim_sessions'"
:silent exec "!mkdir -p $HOME'/.cache/nvim/miniyank'"
:silent exec "!mkdir -p $HOME'/.cache/nvim/shada'"

" Closes the focused window and its buffer if this is not loaded into another window
function! CloseWindowOrKillBuffer()
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction

" Ensures we get each buffer only once
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" General configuration
""""""""""""""""""""""""""""""""""""""""""""""""""

" Changes <leader> for space
let mapleader = " "

" When opening a buffer it will move the cursor at the same place when we closed the buffer
autocmd BufWinLeave *.* silent! mkview
autocmd BufWinEnter *.* silent! loadview
" autocmd FocusLost *.* silent! :wa

" Maintains the same position when we open a buffer in the window as we leave it
if ! &diff
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" Do not create .viminfo file
if !has('nvim')
  set viminfo+=n~/.cache/nvim/viminfo
else
  " Shows the effects of a command incrementally, as you type.
  set inccommand=nosplit

  set shada+=n~/.cache/nvim/shada/main.shada
endif

" Don't want netrw
let loaded_netrw = 0

" Shared clipboard with system
if has('mac')
  set clipboard=unnamed
elseif has('unix')
  set clipboard=unnamedplus
endif

set autoindent                                           " auto indentation
set autoread                                             " Reload files when changed on disk, i.e. via `git checkout`
set backspace=indent,eol,start                           " Allow backspacing over autoindent, line breaks and start of insert action
set breakindent                                          " So wrapped lines stay at the same indentation level
set cmdheight=2
set confirm                                              " Instead of failing a command because of unsaved changes, raises a dialogue asking if you wish to save changed files
set cursorline                                           " Highlights cursor line
set display+=lastline                                    " Always show the last line
set encoding=UTF-8                                       " UTF-8 as a default encoding
set expandtab tabstop=4 softtabstop=4 shiftwidth=4       " Tabs -> 4 spaces
set foldmethod=syntax                                    " code folds will be automatically created based on the syntax settings of the current buffer
set gdefault                                             " Do not need to specify /g on replace
set hidden
set history=10000                                        " Saves last 10000 command lines executions
set hlsearch                                             " Highlights matching searches results
set ignorecase                                           " Case-sensitive search if any caps
set incsearch                                            " Search as you type
set infercase                                            " Case sensitive autocompletion
set iskeyword+=_,@                                       " Not word dividers
set laststatus=2                                         " Always show statusline
set lazyredraw                                           " Do not redraw screen in the middle of a macro, much faster
set linebreak
set listchars=tab:▸\ ,trail:▫,eol:↵,extends:»,precedes:« " Highlighted characters
set mouse=                                               " No mouse allowed
set nobackup
set noerrorbells                                         " No sounds alowed
set nofoldenable                                         " Off on start
set nojoinspaces                                         " Prevents inserting two spaces after punctuation on a join
set nolist                                               " Do not highlight special characters
set nospell                                              " Don't check spell by default
set noswapfile                                           " Don't create swap files
set nowrap sidescroll=1 sidescrolloff=1                  " Don't cut sentences
set nowrapscan
set nowritebackup
set nrformats=                                           " increase or decrease numbers in decimal
set number                                               " Show line numbers
set relativenumber                                       " Shows relative numbers
set ruler                                                " Show where you are
set scrolloff=3                                          " show 3 lines of context around cursor
set shortmess=l
set showcmd                                              " Shows partials of the commands
set signcolumn=yes                                       " Always show signcolumn. prevents buffer from moving when showing/hiding it
set smartcase                                            " Turns case-sensitive search if any caps in the query
set spelllang=en_us,ca,es_es                             " Current spelling dictionaries
set splitright splitbelow                                " Opens new windows on the right and below
set switchbuf=usetab                                     " If a opened buffer is already open, witches to the window that contains it
set tags=./tags;/
set undodir=~/.cache/nvim/nvim_undo                        " Undo folder
set undofile                                             " Persistent undo for buffers
set undolevels=10000                                     " Undo level
set undoreload=10000                                     " Redo level
set updatetime=300
set viewdir=~/.cache/nvim/nvim_view                          " View folder
set visualbell                                           " No visual errors allowed
set wildignore=*/tmp/,*/.git/*,*.so,*.swp,*.zip,*.pdf,*.bak,*.pyc,*.pyo,*.class,*.tmp,*~      " Ignore file types
set wildmenu                                             " Show a navigable menu for tab completion on command line
set wildmode=full

syntax on " Highlighted text

" Colors for the buffer highlight
set t_Co=256                                             " Número de colors
if has('gui_macvim')
    set macligatures
endif
if !has('gui_vimr')
    set guifont=Fira\ Code:h11
endif

set termguicolors
let base16colorspace=256
set background=dark
colorscheme solarized8
highlight SpecialKey ctermbg=NONE guibg=NONE

" Highlights selection in blue
highlight Visual guifg=#1488ad guibg=#022b35
if !has('gui_running')
  " Lighter background when out of vim to focus on the active panel
  highlight Normal ctermbg=NONE guibg=NONE

  " Specific gui options
  set visualbell
  set guioptions-=rL
  " Do not use modal alert dialogs! (Prefer Vim style prompt.)
  " http://stackoverflow.com/questions/4193654/using-vim-warning-style-in-gvim
  set guioptions+=c
  set guicursor=a:blinkon0,a:block-cursor
  map <ScrollWheelUp> <Nop>
  map <ScrollWheelDown> <Nop>
  map <ScrollWheelLeft> <Nop>
  map <ScrollWheelRight> <Nop>
endif

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" let g:solarized_statusline=
fu! StatusLineGitBranch()
  if fugitive#head() == ''
    return ''
  else
    return '['.fugitive#head().']'
  endif
endf

" Status-line
set statusline=
set statusline+=%#Visual#
set statusline+=\ %F
set statusline+=\ %{FugitiveStatusline()}
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%= "Right side settings
set statusline+=\ %([%{&ff}\|%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%k\|%Y]%)
set statusline+=\ %c:%l/%L
set statusline+=\ [%n]


""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert mode custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Exit inser mode with jk
inoremap jk <Esc>

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k


""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-line mode custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Expands with %% in the command line the current buffer folder starting from pwd
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Command line history movement
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Allows save the buffer as a sudo
cmap w!! w !sudo tee % >/dev/null


""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Paste on visual mode does not substitute the buffer
vmap p "_dP

" Bind :sort to something easy, don't press enter, allow for options (eg -u, n, sorting in reverse [sort!])
vnoremap <leader>s :sort<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Normal mode custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>, :EditVifm .<cr>

map j gj
map k gk

" Split movement
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Display the number of matches for the last search
nm <leader># :%s///gn<cr>

" Search whole file
nm <leader>S :%s..g<left><left>

" Toggle spelling and change spelling language
nm <leader>sp :set nospell!<cr>:set nospell?<cr>
nm <leader>se :set spelllang=en_us<cr>
nm <leader>sc :set spelllang=ca<cr>
nm <leader>sñ :set spelllang=es_es<cr>

" Comment/uncomment lines
map <C-c> gcc<Esc>

" Buffer movement
map gb :bnext<cr>
map gB :bprevious<cr>

" Source vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :source $MYVIMRC<cr>
nmap <silent> <leader>ez :e ~/.zshrc<cr>

" Repeats last command from command line
nnoremap :: @:

" Don't need the command history list
map q: :q

" New search result centered vertically in the window
nnoremap n nzz
nnoremap N Nzz

" Copy from the current cursor position to end of line
nmap Y y$

" Split lines
nnoremap K i<cr><Esc>^

" Save buffer
nnoremap <leader>w :w<cr>
" Save and close buffer
nnoremap <leader>W :wq<cr>

" Close buffers
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<cr>

" Selects last pasted text
nnoremap <expr> gv '`[' . strpart(getregtype(), 0, 1) . '`]'

" Specify file buffer path and name to save
map <leader>c :f <C-R>=expand('%:p:h') . '/'<cr>

" Create new buffer
map <leader>e :enew<cr>
" Create a new buffer starting in the same dir as the current file
map <leader>ce :e <C-R>=expand("%:p:h") . "/" <cr>

" Repeats last subtitution command with the same flags
nnoremap & :&&<cr>
xnoremap & :&&<cr>

" From terminal to normal mode with <ESC>
" tnoremap <Esc> <C-\><C-n>

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""

" Opens Undotree
nnoremap <leader>u :UndotreeToggle<cr>
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_DiffpanelHeight = 15
let g:undotree_SetFocusWhenToggle = 1

" vim-session
let g:session_directory = '~/.cache/nvim/nvim_sessions'
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_persist_font = 0
let g:session_persist_colors = 0
let g:session_command_aliases = 1
nnoremap <leader>so :OpenSession 
nnoremap <leader>ss :SaveSession 
nnoremap <leader>sd :DeleteSession<cr>
nnoremap <leader>sc :CloseSession<cr>

" smoothie
let g:smoothie_base_speed = 30

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" miniyank
let g:miniyank_filename = $HOME.'/.cache/nvim/miniyank/miniyank'
let g:miniyank_maxitems = 100

function! FZFYankList() abort
  function! KeyValue(key, val)
    let line = join(a:val[0], '')
    if (a:val[1] ==# 'V')
      let line = line
    endif
    return a:key.' '.line
  endfunction
  return map(miniyank#read(), function('KeyValue'))
endfunction

function! FZFYankHandler(opt, line) abort
  let key = substitute(a:line, ' .*', '', '')
  if !empty(a:line)
    let yanks = miniyank#read()[key]
    call miniyank#drop(yanks, a:opt)
  endif
endfunction

function! MiniPut(before)
  let l:fzf_files_options = '--preview "echo {}" --reverse'
  if (a:before)
    let l:parameter = ['P']
    let l:beforeAfter = 'Before'
  else
    let l:parameter = ['p']
    let l:beforeAfter = 'After'
  endif

  let opts = fzf#wrap({})
  let opts['source'] = FZFYankList()
  let opts['sink'] = function('FZFYankHandler', l:parameter)
  let opts['options'] = '-m ' . g:fzf_default_preview_window . ' --prompt "Put ' . l:beforeAfter . ' > " ' . l:fzf_files_options . ' ' . g:fzf_default_bind

  call fzf#run(opts)
endfunction

nnoremap <silent> <leader>P :call MiniPut(1)<cr>
nnoremap <silent> <leader>p :call MiniPut(0)<cr>

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
endif
let g:fzf_layout = { 'down': '~50%' }
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_action = { 'ctrl-z': 'split' }

command! -bar -bang -nargs=? -complete=buffer Buffers 
            \call fzf#vim#buffers(<q-args>, { "options": ["--preview", "bat --style=numbers,changes --color=always {3}"] }, <bang>0)

nmap <leader>f :Files<cr>
nmap <leader>g :GFiles<cr>
nmap <leader>m :GFiles?<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>h :History<cr>
