" VIM PLUG plugins manager ------------------------------------------------------
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

let g:has_async = v:version >= 800 || has('nvim')

call plug#begin('~/.config/nvim/autoload/plugged')
  " If fzf has already been installed via Homebrew, use the existing fzf
  " Otherwise, install fzf. The `--all` flag makes fzf accessible outside of vim
  if isdirectory("/usr/local/opt/fzf")
    Plug '/usr/local/opt/fzf'
  else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  endif
  Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
  Plug 'mileszs/ack.vim'
  "Plug 'elixir-lang/vim-elixir'
  "Plug 'fatih/vim-go'
  Plug 'pangloss/vim-javascript'
  " better syntax support
  Plug 'sheerun/vim-polyglot'
  " file explorer
  Plug 'scrooloose/NERDTree'
  "
  " auto pairs for '(' '[' '{'
  Plug 'jiangmiao/auto-pairs'
  "
  " a dark vim/neovim color scheme
  Plug 'joshdick/onedark.vim'
  "
  " lean & mean status/tabline for vim that's light as air
  Plug 'vim-airline/vim-airline'
  " TODO: customize z section in status line
  "
  Plug 'jlanzarotta/bufexplorer'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-endwise'
  Plug 'ap/vim-css-color'
  Plug 'vim-scripts/tComment'
  Plug 'janko-m/vim-test'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'slim-template/vim-slim'
  Plug 'tpope/vim-rake'
  Plug 'tpope/vim-rhubarb'
  Plug 'vim-ruby/vim-ruby'
  Plug 'ryanoasis/vim-devicons'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'
  Plug 'coreyja/fzf.devicon.vim'
  Plug 'kaicataldo/material.vim', { 'branch': 'main' } "material theme for vim
  "
  "Plug 'tpope/vim-eunuch'
  "Plug 'tpope/vim-fugitive'
  "Plug 'tpope/vim-projectionist'
  "Plug 'tpope/vim-repeat'

  if g:has_async
    Plug 'dense-analysis/ale' "syntax checker
  endif
call plug#end()

" GENERAL -----------------------------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
syntax on                                             "enable syntax highlighting
set termguicolors
" colorscheme onedark
colorscheme material
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
let g:material_theme_style = 'default' 
if (has('termguicolors'))
  set termguicolors
endif
set nocompatible                                            "don't behave like VI
set number                              "set line numbers. set nonu - turn it off
set hlsearch                                           "highlights search results
set incsearch                                   "shows search matches as you type
set showmatch                                            "shows matching brackets
set smartcase                                                "if caps, watch case
set ignorecase                                     "if all lowercase, ignore case
set mouse=a                                           "enable mouse for all modes
set showfulltag               "when completing tags in Insert mode show more info
set undofile
set directory=~/.local/share/nvim/swap/    "list of directories for the swap file
"set omnifunc=syntaxcomplete#Complete         "enable omni complettion i<C-X><C-O>

let mapleader=","

set listchars=tab:▸\ ,eol:¬,trail:·         "use the same symbols as TextMate for
                                                               "tabstops and EOLs
" PLUGINS CONFIG ----------------------------------------------------------------
" ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
nnoremap <Leader>A :Ack! -Q<Space>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" nerdtree toggle
map <silent> <leader>n :NERDTreeToggle<CR>
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=40

" ALE
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_autoimport = 1

" SHRORCUTS ---------------------------------------------------------------------
" show invisible character
nmap <leader>l :set list!<CR>
" strip trailing whitespaces
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
nnoremap <c-p> :GFiles<cr>
nnoremap <c-0> :Files<cr>
" nnoremap <M-P> :Files<cr> "TODO: map this to smth usefull
nmap <leader><space> :nohlsearch<CR>
"edit ~/.vimrc in new tab
nmap <leader>evrc :tabedit $MYVIMRC<CR>

" ABBREVIATIONS -----------------------------------------------------------------
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev wQ wq

" AUTOCMD SETTINGS --------------------------------------------------------------
if has("autocmd")
  autocmd BufWritePre *.py,*.js,*.rb,*.coffee,*.erb,*.slim,*.skim,*.rake,*.yml :call <SID>StripTrailingWhitespaces()
  autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
  autocmd BufNewFile,BufRead *.scss set filetype=sass
  autocmd BufNewFile,BufRead *.less set filetype=less
  autocmd BufNewFile,BufRead *.fbml.erb set filetype=eruby
  autocmd BufNewFile,BufRead *.json set filetype=json
  autocmd BufNewFile,BufRead *.(rdf|xml) set filetype=xml
  autocmd BufNewFile,BufRead *.prawn set ft=ruby
  autocmd BufNewFile,BufRead *.skim set ft=slim
  autocmd BufNewFile,BufRead /opt/nginx/conf/* set ft=nginx
  autocmd FileType nerdtree nmap <buffer> <leader>be :NERDTreeClose<CR>:BufExplorer<CR>
  "add spell checking and automatic wrapping at the recommended 72 columns to you commit messages.
  "https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
  autocmd FileType gitcommit setlocal spell textwidth=72
  " START """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "autocmd FileType ruby let g:ruby_host_prog = '~/.rbenv/shims/neovim-ruby-host'
  "autocmd FileType ruby let g:ruby_path = system('echo $HOME/.rbenv/shims')
  "autocmd FileType ruby set omnifunc=rubycomplete#Complete
  " related to vim-ruby plugin config
  "autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  "autocmd FileType ruby let g:rubycomplete_classes_in_global=1
  "autocmd FileType ruby let g:rubycomplete_rails = 1
  "autocmd FileType ruby let g:rubycomplete_load_gemfile = 1
  "autocmd FileType ruby let g:rubycomplete_use_bundler = 1
  " END """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  autocmd FileType crontab setlocal nobackup nowritebackup
  autocmd FileType json nmap <buffer> <leader>fj :%!python -m json.tool
  autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
  "ts - show existing tab with 4 spaces width
  "sw - when indenting with '>', use 4 spaces width
  "sts - control <tab> and <bs> keys to match tabstop
endif

" FUNCTIONS ---------------------------------------------------------------------
function! <SID>StripTrailingWhitespaces()
    "Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    "Do the business:
    %s/\s\+$//e
    "Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

let s:colors = {
  \ 'brown'       : "905532",
  \ 'aqua'        : "3AFFDB",
  \ 'blue'        : "689FB6",
  \ 'darkBlue'    : "44788E",
  \ 'purple'      : "834F79",
  \ 'lightPurple' : "834F79",
  \ 'red'         : "AE403F",
  \ 'beige'       : "F5C06F",
  \ 'yellow'      : "F09F17",
  \ 'orange'      : "D4843E",
  \ 'darkOrange'  : "F16529",
  \ 'pink'        : "CB6F6F",
  \ 'salmon'      : "EE6E73",
  \ 'green'       : "8FAA54",
  \ 'lightGreen'  : "31B53E",
  \ 'white'       : "FFFFFF"
\ }


"""""""""""""""""""""" USEFULL COMMANDS """"""""""""""""""""""""""

" /\t                   show all tabs:
" /\s\+$                show trailing whitespace:
" / \+\ze\t             show spaces before a tab:
" :reatb!               refactoring indentation on whole file.
" Example: :set noexpandtab ; :retab!

" :%s/\s\+$//e      removes trailong whitespaces. : comd line ; %s short for $
" substitute command % specifies that the entire file will be affected ;
" first fowrard slashes - delimit search pattern ; \s white space char ; \+
" indicates one or more spaces will be matched before line end $ ; last 2
" slashes delimit replacement string (blank) ; e flag supresses of error message
" if no matches were found.

" :g/^$/d           deletes blank lines
" :g - creates a global command ; /^$/ search pattern ; /d - command to execute
"

