" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:

if has('vim_starting')
    set nocompatible
    set nofoldenable
    set fileencoding=utf-8
    set termencoding=utf-8
    scriptencoding utf-8
    set encoding=utf-8
    let mapleader = ","
    let g:mapleader = ","
endif

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

augroup pandoc " {
    autocmd!
    autocmd Filetype pandoc setlocal wrap textwidth=79
augroup END " }

augroup rst
    autocmd!
    autocmd Filetype rst index.rst let g:syntastic_rst_checkers = ['sphinx']
augroup END

augroup go " {
    autocmd Filetype go nnoremap <leader>gd :vsp<CR> : exe "GoDef"<CR>

augroup END " }

augroup savefile " {
    " autocmd BufWritePre * :%s/\s\+$//e
augroup END " }
" *** Plugin Management *** {

    call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-vinegar'
    " Plug 'tpope/vim-sensible'

    " Plugin outside ~/.vim/plugged with post-update hook
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    Plug 'noah/vim256-color'

    Plug 'fatih/vim-go'
    Plug 'Valloric/YouCompleteMe'
    Plug 'scrooloose/syntastic'

    " javascript
    " Plug 'pangloss/vim-javascript'

    " plantuml
    Plug 'aklt/plantuml-syntax'

    " Restructured Text
    " Plug 'Rykka/riv.vim'
    " Pandoc
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'vim-pandoc/vim-pandoc-after'

    Plug 'editorconfig/editorconfig-vim'
    call plug#end()
" }
"
" My Settings {
    set t_Co=256
    set list
    set listchars=trail:•,precedes:«,extends:»,tab:▸\ 
    colorscheme solarized
    set background=dark
    set pastetoggle=<F2>
    filetype plugin indent on

    "--- Scrolling --- {
    set scrolljump=5
    set scrolloff=3
    set sidescrolloff=3
    " }
" { --- Backups ---
    set undodir=~/.vim/.undo//
    set backupdir=~/.vim/.backup//
    set directory=~/.vim/.swp//
" }
    set wrap
    set textwidth=79
    set autoindent
    set shiftwidth=4
    set smarttab
    set expandtab
    set tabstop=4
    set softtabstop=4
    set nojoinspaces

    "--- Search Settings --- {
    set incsearch
    set hlsearch
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    " Use <C-L> to clear the highlighting of :set hlsearch.
    if maparg('<C-L>', 'n') ==# ''
      nnoremap <silent> <C-L>
        \ :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
    endif
    "--- Search Settings --- }

    "--- Wild Menu --- {
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full
    " Ignore compiled files
    set wildignore=*.o,*~,*.pyc
    if has("win16") || has("win32")
        set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Storeelse
    else
        set wildignore+=.git\*,.hg\*,.svn\*
    endif
    " }
" }
" My Mappings {
    " exapnd %% to current buffer dir
    cabbr <expr> %% expand('%:p:h')
    " capitalize the word last edited
    inoremap <C-y> <esc>gUiw`]a

    nnoremap <leader>w :update<CR>
    inoremap <C-x> <nop>
    inoremap jk <esc>
    inoremap JK <esc>
    nnoremap Y y$
    nnoremap ö :
    nnoremap <leader>le :set listchars-=eol:↲<CR>
    nnoremap <leader>lE :set listchars+=eol:↲<CR>
" }
" --- Status Line --- {
if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%t\                     " Filename
    set statusline+=(%{&fo})                 " formatting options
    set statusline+=%w%h%m                   " Options
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    if exists(':Gread')
        set statusline+=%{fugitive#statusline()} " Git Hotness
    endif
    " set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%Y]            " Filetype
    " set statusline+=\ [%{getcwd()}]          " Current dir
    " set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    set statusline+=%=%-14.(%l/%L,%c%V%)\      " Right aligned file nav info
endif
" }
" Plugin Configuration {
if exists(':Files')
    nnoremap <leader>ff :<C-u>:Files<cr>
    nnoremap <leader>fg :<C-u>:GitFiles<cr>
    nnoremap <leader>fs :<C-u>:GitFiles?<cr>
    nnoremap <leader>fb :<C-u>:Buffers<cr>
    nnoremap <leader>ft :<C-u>:BTags<cr>
    nnoremap <leader>fh :<C-u>:History<cr>
endif
if has('cscope')
    set cscopetag
    set csto=0
    set cscopeverbose
    nmap <leader>cs :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>cg :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>ct :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>ce :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>cf :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>ci :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>cd :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" GO Configuration {
    " use goimports for formatting
    let g:go_fmt_command = "goimports"

    " turn highlighting on
    "  let g:go_highlight_functions = 1
    "  let g:go_highlight_methods = 1
    "  let g:go_highlight_structs = 1
    "  let g:go_highlight_operators = 1
    "  let g:go_highlight_build_constraints = 1

    let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

    " Open go doc in vertical window, horizontal, or tab
    au Filetype go nnoremap <leader>av :vsp <CR>:exe "GoDef" <CR>
    au Filetype go nnoremap <leader>as :sp <CR>:exe "GoDef"<CR>
    au Filetype go nnoremap <leader>at :tab split <CR>:exe "GoDef"<CR>
" }

let g:syntastic_python_python_exec = "/usr/bin/env python"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

if exists(':YcmForceCompileAndDiagnostics')
    let g_ycm_python_binary_path = '/usr/bin/python3'
    " Delete logfiles after ycmserver shuts down
    let g:ycm_server_keep_logfiles = 0

    "    " Don't use neocomplete even if it is loaded
    let g:neocomplete#enable_at_startup = 0
    "
    "    " Vim's location list
    let g:ycm_always_populate_location_list = 1
    "
    " Automatically open the location list after forcing compilation
    let g:ycm_open_loclist_on_ycm_diags = 1
    "
    "   Use the language identifiers known by Vim for the filetype
    "   as a source for completions(default 0)
    let g:ycm_seed_identifiers_with_syntax = 1
    "    " use exuberant ctags if specified in vim's tags option
    "    " tags file needs to be generated with --fields+=l
    let g:ycm_collect_identifiers_from_tags_files = 0
    "
    "    let g:ycm_confirm_extra_conf = 1
    "    " Running command YcmDiags will open locationlist
    "    " in case of errors/warnings  unless the following line is uncommented.
    "    " let g:ycm_open_loclist_on_ycm_diags = 0
    "
    "    " Uncomment to turn off identifier completion
    "    " let g:ycm_min_num_of_chars_for_completion = 99
    "
    "    " Sensible goto: definition of the symbol under cursor
    "    " if it is found in the current compilation unit
    "    nnoremap <leader>jj :YcmCompleter GoTo<CR>
    "
    "    " YCM uses vim's location list for file specifc error
    "    " locations.
endif
" }

nnoremap <leader>ff :<C-u>:Files<cr>
nnoremap <leader>fg :<C-u>:GitFiles<cr>
nnoremap <leader>fs :<C-u>:GitFiles?<cr>
nnoremap <leader>fb :<C-u>:Buffers<cr>
nnoremap <leader>ft :<C-u>:BTags<cr>
nnoremap <leader>fh :<C-u>:History<cr>
