""""""""""""""""""""""""""""""""""""""""""""""""""
" vim/neovim config file
""""""""""""""""""""""""""""""""""""""""""""""""""

let using_neovim = has('nvim')
let using_vim = !using_neovim

" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
if using_neovim
  let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
  let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif

if !filereadable(vim_plug_path)
  echo "Installing Vim-plug..."
  echo ""
  if using_neovim
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  else
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
  let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
  :execute 'source '.fnameescape(vim_plug_path)
endif

" Creates cache folders
:silent exec "!mkdir -p $HOME'/.cache/nvim/nvim_undo'"
:silent exec "!mkdir -p $HOME'/.cache/nvim/nvim_view'"
:silent exec "!mkdir -p $HOME'/.cache/nvim/miniyank'"
:silent exec "!mkdir -p $HOME'/.cache/nvim/shada'"

" vim-plug: Plugins section
call plug#begin('~/.config/nvim/plugged')

  " User Interface
  Plug 'https://github.com/dracula/vim.git', { 'name': 'dracula' }
  Plug 'https://github.com/machakann/vim-highlightedyank'   " Highlights in red the yanked text
  Plug 'https://github.com/psliwka/vim-smoothie'            " Smoothie scroll (using [Ctrl-u], [Ctrl-d], [Ctrl-b] and [Ctrl-f]
  Plug 'https://github.com/gillyb/stable-windows'           " When opening splits, maintains the same layout (working?)
  Plug 'https://github.com/zakj/vim-showmarks'              " Adds marks to gutter
    let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  " Fuzzy finder
  Plug '/usr/local/opt/fzf'                                 " Fuzzy finder in Vim
  Plug 'https://github.com/junegunn/fzf.vim'                " Extended Fuzzy finder commands

  " Intregration of Git
  Plug 'https://github.com/tpope/vim-fugitive'              " Best Git plugin for Vim
  Plug 'https://github.com/junegunn/gv.vim'                 " A git commit browser in Vim
  Plug 'https://github.com/airblade/vim-gitgutter'          " Adds Git changes in lines
    let g:gitgutter_map_keys = 0
    let g:gitgutter_grep = 'rg'
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
  Plug 'https://github.com/farmergreg/vim-lastplace'        " Opens the current in the same last position before close it

  " Other
  Plug 'https://github.com/wellle/targets.vim'              " Adds text objects and improves the default ones
  Plug 'https://github.com/mbbill/undotree'                 " Shows undo tree for the current buffer
  Plug 'https://github.com/pbrisbin/vim-mkdir'              " Creates all required folders when saving buffers
  Plug 'https://github.com/tpope/vim-obsession'             " Improves Vim session management

  Plug 'https://github.com/christoomey/vim-tmux-navigator'  " Seamless navigation between tmux panes and vim splits
  Plug 'https://github.com/tpope/vim-unimpaired'            " Mappings for common ex commands, line mappings (add before/after, movement), toggle vim options and encode/decode
  Plug 'https://github.com/bfredl/nvim-miniyank'            " Saves in disk yanked or deleted text so it will be shared between vim instances
  Plug 'https://github.com/vifm/vifm.vim'                   " Vim plugin that allows use of vifm as a file picker
  Plug 'https://github.com/mhinz/vim-grepper'               " Multiple kind of greps, populates quickfix or location list
  Plug 'https://github.com/arielrossanigo/dir-configs-override.vim' " If exists a .vim.custom file in the current folder or parents, overrides default settings stored in this files
  Plug 'https://github.com/vim-scripts/IndexedSearch'       " Shows 'Nth match out of M' at every search

  " Coc
  Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}           " Intellisense engine for Vim/Neovim
  Plug 'https://github.com/liuchengxu/vista.vim'            " Tagbar that learns from LSP servers
  Plug 'https://github.com/jeetsukumaran/vim-pythonsense'   " Provides some Python-specific text objects: classes, functions, etc
  Plug 'https://github.com/Vimjas/vim-python-pep8-indent'   " Indentation for Python
  Plug 'https://github.com/vim-syntastic/syntastic'
  Plug 'https://github.com/keith/swift.vim'
  Plug 'https://github.com/SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
  Plug 'https://github.com/honza/vim-snippets'
  Plug 'https://github.com/liuchengxu/vim-which-key'        " Shows menu with the keys and what they do

call plug#end()

" Install plugins the first time vim runs
if vim_plug_just_installed
  echo "Installing Bundles, please ignore key map error messages"
  :PlugInstall
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Funcions
"""""""""""""""""""""""""""""""""""""""""""""""""""

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

let g:lt_height = get( g:, 'lt_height', 10 )
command! LToggle call s:LListToggle()
function! s:LListToggle() abort
  let buffer_count_before = s:BufferCount()
  " Location list can't be closed if there's cursor in it, so we need 
  " to call lclose twice to move cursor to the main pane
  silent! lclose
  silent! lclose

  if s:BufferCount() == buffer_count_before
    execute "silent! lopen " . g:lt_height
  endif
endfunction

command! QToggle call s:QListToggle()
function! s:QListToggle() abort
  let buffer_count_before = s:BufferCount()
  silent! cclose

  if s:BufferCount() == buffer_count_before
    execute "silent! botright copen " . g:lt_height
  endif
endfunction

function! s:BufferCount() abort
    return len(filter(range(1, bufnr('$')), 'bufwinnr(v:val) != -1'))
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" General configuration
""""""""""""""""""""""""""""""""""""""""""""""""""

" Changes <leader> for space
let mapleader = " "
nnoremap <Space> <Nop>

" When opening a buffer it will move the cursor at the same place when we closed the buffer
autocmd BufWinLeave *.* silent! mkview
autocmd BufWinEnter *.* silent! loadview

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
set mouse=r                                              " No mouse allowed
set nobackup
set noerrorbells                                         " No sounds alowed
set nofoldenable                                         " Off on start
set nojoinspaces                                         " Prevents inserting two spaces after punctuation on a join
set nolist                                               " Do not highlight special characters
set nospell                                              " Don't check spell by default
set noswapfile                                           " Don't create swap files
set nowrap sidescroll=1 sidescrolloff=1                  " Don't cut sentences
set nowritebackup
set nrformats=                                           " increase or decrease numbers in decimal
set number                                               " Show line numbers
set pumheight=20                                         " Popup menu smaller
set relativenumber                                       " Shows relative numbers
set ruler                                                " Show where you are
set shortmess=lcs                                        " Personalizes some messages
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
set wrapscan

syntax on " Highlighted text

" Colors for the buffer highlight
set t_Co=256                                             " Número de colors
if has('gui_macvim')
    set macligatures
endif
if !has('gui_vimr')
    set guifont=Fira\ Code:h11
endif

highlight Cursor cterm=reverse gui=reverse
highlight iCursor cterm=reverse gui=reverse

set termguicolors
let base16colorspace=256
colorscheme dracula

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

" Status-line
set statusline=
set statusline+=%#CursorLine#
set statusline+=\ %F
set statusline+=\ %{FugitiveStatusline()}
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%= "Right side settings
set statusline+=\ %([%Y]%)
set statusline+=\ %l/%L\ 

""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert mode custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Exit inser mode with jk
imap jk <Esc>
imap jj <Esc>

" Disable arrow keys in insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-line mode custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Expands with %% in the command line the current buffer folder starting from pwd
cmap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Command line history movement
cmap <C-p> <Up>
cmap <C-n> <Down>

" Allows save the buffer as a sudo
cmap w!! w !sudo tee % >/dev/null


""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Paste on visual mode does not substitute the buffer
vmap p "_dP

" Bind :sort to something easy, don't press enter, allow for options (eg -u, n, sorting in reverse [sort!])
vmap <leader>s :sort<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""
" Normal mode custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable arrow keys in normal mode
nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>

" Comment/uncomment lines
map <C-c> gcc<Esc>

noremap j gj
noremap k gk

" Buffer movement
nmap gb :bnext<cr>
nmap gB :bprevious<cr>

" Toggle spelling and change spelling language
" nmap leader>sp :set spell! spell?<cr>
nmap <leader>se :set spelllang=en_us<cr>
nmap <leader>sc :set spelllang=ca<cr>
nmap <leader>sñ :set spelllang=es_es<cr>

" Moves the cursor to the lines with git changes
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)

" Repeats last command from command line
nmap :: @:

" Don't need the command history list
nmap q: :q

" Copy from the current cursor position to end of line
nmap Y y$

" Close buffers
nmap <silent> Q :call CloseWindowOrKillBuffer()<cr>

" Selects last pasted text
nmap <expr> gv '`[' . strpart(getregtype(), 0, 1) . '`]'

" Specify file buffer path and name to save
nmap <leader>c :f <C-R>=expand($PWD) . '/'<cr>

nmap K i<cr><esc>

" Moves current line up or down with <A-k> and <A-j>
noremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Repeats last subtitution command with the same flags
map & :&&<cr>
xmap & :&&<cr>

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""

" Opens Undotree
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_DiffpanelHeight = 15
let g:undotree_SetFocusWhenToggle = 1

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

let g:fzf_default_bind = '--bind change:top,ctrl-w:backward-kill-word,ctrl-a:beginning-of-line,ctrl-e:end-of-line,shift-right:forward-word,shift-left:backward-word,ctrl-c:clear-query,ctrl-f:page-down,ctrl-b:page-up,ctrl-u:half-page-up,ctrl-d:half-page-down,ctrl-t:top,ctrl-p:up,ctrl-n:down,ctrl-o:toggle-sort,ctrl-x:toggle,tab:toggle-out,btab:toggle-up,alt-e:preview-down,alt-y:preview-up,alt-j:preview-page-down,alt-k:preview-page-up,alt-f:preview-page-down,alt-b:preview-page-up,alt-p:toggle-preview'
let g:fzf_default_preview_window = '--preview-window=bottom:50%:border'
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

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
endif
let g:fzf_layout = { 'down': '~50%' }
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_action = { 'ctrl-z': 'split' }
let g:fzf_action2 = { 'ctrl-z': 'split' }

command! -bar -bang -nargs=? -complete=buffer Buffers 
            \call fzf#vim#buffers(<q-args>, { "options": ["--preview", "bat --style=numbers,changes --color=always {3}"] }, <bang>0)

" fzf Statusline colors
highlight default fzf1 ctermfg=1 ctermbg=8 guifg=#62f591 guibg=#424450
highlight default fzf2 ctermfg=2 ctermbg=8 guifg=#f7f8f3 guibg=#424450
highlight default fzf3 ctermfg=7 ctermbg=8 guifg=#f7f8f3 guibg=#424450

let g:python3_host_prog='/usr/local/opt/python/bin/python3'

" Coc
let g:coc_data_home = $HOME.'/.cache/coc'
let g:coc_config_home = $HOME.'/.nvim'

" Use ; to show do;cumentation in preview window
" nmap <silent> ; :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> <leader>co :<C-u>CocList outline<cr>
nmap <silent> <leader>cs :<C-u>CocList -I symbols<cr>

" List errors
nmap <silent> <leader>cl :<C-u>CocList locationlist<cr>

" list commands available in tsserver (and others)
nmap <silent> <leader>cc :<C-u>CocList commands<cr>

" restart when tsserver gets wonky
nmap <silent> <leader>cR :<C-u>CocRestart<CR>

" view all errors
nmap <silent> <leader>cl :<C-u>CocList locationlist<CR>

" manage extensions
nmap <silent> <leader>cx :<C-u>CocList extensions<cr>

" Remap for rename current word
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>cf <Plug>(coc-format-selected)
vmap <leader>cf <Plug>(coc-format-selected)

" run code actions
vmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>ca <Plug>(coc-codeaction-selected)

au BufNewFile,BufRead *.py
    \ set foldmethod=indent

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
    \ set fileformat=unix

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_swift_checkers = ['swiftlint']

" If exists a Session.vim file in the current folder, sources it
if filereadable(getcwd() . '/.session.vim')
  :execute 'source '.getcwd() . '/.session.vim'
endif

" vim-which-key

nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<space>'<cr>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<space>'<cr>

" Create map for leader to add keys to
let g:which_key_leader = {}
let g:which_key_leader['name'] = 'leader root'

" Change the colors if you want
highlight default link WhichKey          Error
highlight default link WhichKeySeperator String
highlight default link WhichKeyGroup     Function
highlight default link WhichKeyDesc      Identifier

let g:which_key_leader[',']  = [ ':EditVifm'               , 'Open Vifm']
let g:which_key_leader['-']  = [ '<C-W>s'                  , 'Split below']
let g:which_key_leader['|']  = [ '<C-W>v'                  , 'Split right']
let g:which_key_leader['.']  = [ ':edit $MYVIMRC'          , 'Edit init.vim' ]
let g:which_key_leader['/']  = [ ':Commentary'             , 'Comment line' ]
let g:which_key_leader['e']  = [ ':CocCommand explorer'    , 'Coc Explorer']
let g:which_key_leader['n']  = [ ':enew'                   , 'New buffer']
let g:which_key_leader['q']  = [ 'q'                       , 'Quit' ]
let g:which_key_leader['w']  = [ 'w'                       , 'Write' ]
let g:which_key_leader['P']  = [ ':call MiniPut(1)'        , 'Put before history yank' ]
let g:which_key_leader['p']  = [ ':call MiniPut(0)'        , 'Put after history yank' ]

let g:which_key_leader.b = {
      \ 'name' : '+buffer',
      \ 'd' : [':call CloseWindowOrKillBuffer'        , 'Closes current window or buffer'],
      \ 'f' : ['bfirst'                               , 'First buffer'],
      \ 'l' : ['blast'                                , 'Last buffer'],
      \ 'n' : ['bnext'                                , 'Next buffer'],
      \ 'p' : ['bprevious'                            , 'Previous buffer'],
      \ '?' : ['Buffers'                              , 'FZF buffers'],
      \ }

let g:which_key_leader.g = {
      \ 'name' : '+git',
      \ 'a' : [':Git add %'                           , 'Add current file'],
      \ 'A' : [':Git add .'                           , 'Add all files'],
      \ 'b' : [':Git blame'                           , 'Blame'],
      \ 'B' : [':GBrowse'                             , 'Browse'],
      \ 'c' : [':Git commit'                          , 'Commit'],
      \ 'd' : [':Git diff'                            , 'Diff'],
      \ 'D' : [':Gdiffsplit'                          , 'Diff split'],
      \ 'G' : [':Gstatus'                             , 'Status'],
      \ 'h' : [':GitGutterLineHighlightsToggle'       , 'Highlight hunks'],
      \ 'H' : ['<Plug>(GitGutterPreviewHunk)'         , 'Preview hunk'],
      \ 'j' : ['<Plug>(GitGutterNextHunk)'            , 'Next hunk'],
      \ 'k' : ['<Plug>(GitGutterPrevHunk)'            , 'Prev hunk'],
      \ 'l' : [':Git log'                             , 'Log'],
      \ 'p' : [':Git push'                            , 'Push'],
      \ 'P' : [':Git pull'                            , 'Pull'],
      \ 'r' : [':GRemove'                             , 'Remove'],
      \ 's' : ['<Plug>(GitGutterStageHunk)'           , 'Stage hunk'],
      \ 't' : [':GitGutterSignsToggle'                , 'Toggle signs'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)'            , 'Undo hunk'],
      \ 'v' : [':GV'                                  , 'View project commits'],
      \ 'V' : [':GV!'                                 , 'View current buffer commits'],
      \ }

let g:which_key_leader.l = {
      \ 'name' : '+lsp',
      \ '.' : [':CocConfig'                           , 'Config'],
      \ ';' : ['<Plug>(coc-refactor)'                 , 'Refactor'],
      \ 'a' : ['<Plug>(coc-codeaction)'               , 'Line action'],
      \ 'A' : ['<Plug>(coc-codeaction-selected)'      , 'Selected action'],
      \ 'b' : [':CocNext'                             , 'Next action'],
      \ 'B' : [':CocPrev'                             , 'Prev action'],
      \ 'c' : [':CocList commands'                    , 'Commands'],
      \ 'd' : ['<Plug>(coc-definition)'               , 'Definition'],
      \ 'D' : ['<Plug>(coc-declaration)'              , 'Declaration'],
      \ 'e' : [':CocList extensions'                  , 'Extensions'],
      \ 'f' : ['<Plug>(coc-format-selected)'          , 'Format selected'],
      \ 'F' : ['<Plug>(coc-format)'                   , 'Format'],
      \ 'h' : ['<Plug>(coc-float-hide)'               , 'Hide'],
      \ 'i' : ['<Plug>(coc-implementation)'           , 'Implementation'],
      \ 'I' : [':CocList diagnostics'                 , 'Diagnostics'],
      \ 'j' : ['<Plug>(coc-float-jump)'               , 'Float jump'],
      \ 'l' : ['<Plug>(coc-codelens-action)'          , 'Code lens'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'          , 'Next diagnostic'],
      \ 'N' : ['<Plug>(coc-diagnostic-next-error)'    , 'Next error'],
      \ 'O' : [':CocList outline'                     , 'Outline'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'          , 'Prev diagnostic'],
      \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'    , 'Prev error'],
      \ 'q' : ['<Plug>(coc-fix-current)'              , 'Quickfix'],
      \ 'r' : ['<Plug>(coc-rename)'                   , 'Rename'],
      \ 'R' : ['<Plug>(coc-references)'               , 'References'],
      \ 's' : [':CocList -I symbols'                  , 'References'],
      \ 't' : ['<Plug>(coc-type-definition)'          , 'Type definition'],
      \ 'u' : [':CocListResume'                       , 'Resume list'],
      \ 'U' : [':CocUpdate'                           , 'Update CoC'],
      \ 'v' : [':Vista!!'                             , 'Tag viewer'],
      \ 'z' : [':CocDisable'                          , 'Disable CoC'],
      \ 'Z' : [':CocEnable'                           , 'Enable CoC'],
      \ }

let g:which_key_leader.m = {
      \ 'name' : '+marks',
      \ 'a' : [':ShowMarksClearAll'                   , 'Clear all marks of current buffer'],
      \ 'h' : [':ShowMarksClearMark'                  , 'Clear current mark'],
      \ 'm' : [':ShowMarksPlaceMark'                  , 'Places new mark in current line'],
      \ 'o' : [':ShowMarksOn'                         , 'Forces ShowMarks on'],
      \ 't' : [':ShowMarksToggle'                     , 'Toggle ShowMarks'],
      \ }

let g:which_key_leader.s = {
      \ 'name' : '+search/session',
      \ '/' : [':History/'                            , 'History'],
      \ ';' : [':Commands'                            , 'Commands'],
      \ 'b' : [':Buffers'                             , 'Open buffers'],
      \ 'B' : [':BLines'                              , 'Current buffer'],
      \ 'c' : [':Commits'                             , 'Commits'],
      \ 'd' : [':Obsession!'                          , 'Removes current session'],
      \ 'C' : [':BCommits'                            , 'Buffer commits'],
      \ 'f' : [':Files'                               , 'Files'],
      \ 'g' : [':GFiles'                              , 'Git files'],
      \ 'G' : [':GFiles?'                             , 'Modified git files'],
      \ 'h' : [':History'                             , 'File history'],
      \ 'H' : [':History:'                            , 'Command history'],
      \ 'l' : [':Lines'                               , 'Lines'] ,
      \ 'm' : [':Marks'                               , 'Marks'] ,
      \ 'o' : [':Obsession .session.vim'              , 'Saves session'],
      \ 'M' : [':Maps'                                , 'Normal maps'] ,
      \ 'p' : [':Helptags'                            , 'Help tags'] ,
      \ 'P' : [':Tags'                                , 'Project tags'],
      \ 's' : [':Snippets'                            , 'Snippets'],
      \ 't' : [':Rg'                                  , 'Text Rg'],
      \ 'T' : [':BTags'                               , 'Buffer tags'],
      \ 'w' : [':Windows'                             , 'Search windows'],
      \ 'y' : [':Filetypes'                           , 'File types'],
      \ 'z' : [':FZF'                                 , 'FZF'],
      \ }

let g:which_key_leader.t = {
      \ 'name' : '+toggle',
      \ 'g' : [':GitGutterSignsToggle'                , 'Toggle Git signs'],
      \ 'h' : [':set hlsearch!'                       , 'Toggle search highlight'],
      \ 'l' : [':LToggle'                             , 'Toggle location list'],
      \ 'm' : [':ShowMarksToggle'                     , 'Toggle ShowMarks'],
      \ 'n' : [':set nonumber!'                       , 'Toggle line numbers'],
      \ 'q' : [':QToggle'                             , 'Toggle quickfix list'],
      \ 's' : [':set spell!'                          , 'Toggle spelling'],
      \ 'u' : [':UndotreeToggle'                      , 'Toggle undotree'],
      \ 'v' : [':Vista!!'                             , 'Toggle Vista tag viewer'],
      \ }

call which_key#register('<space>', "g:which_key_leader")

" nnoremap <silent> g :silent <c-u> :silent WhichKey 'g'<cr>
" vnoremap <silent> g :silent <c-u> :silent WhichKeyVisual 'g'<cr>
let g:which_key_g =  {}
let g:which_key_g['b'] = [ ':bnext'                , 'Next Buffer' ]
let g:which_key_g['B'] = [ ':bprev'                , 'Previous Buffer' ]
call which_key#register('g', "g:which_key_g")
nnoremap <silent> ] :silent <c-u> :silent WhichKey ']'<cr>
vnoremap <silent> ] :silent <c-u> :silent WhichKeyVisual ']'<cr>
nnoremap <silent> [ :silent <c-u> :silent WhichKey '['<cr>
vnoremap <silent> [ :silent <c-u> :silent WhichKeyVisual '['<cr>
