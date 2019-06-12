" grouping and ordering according :options
" pathogen - must come first --------------------------------------------------
execute pathogen#infect()
" set rubydll path for macvim
if has("gui_macvim")
  set rubydll=~/.rvm/rubies/ruby-2.6.0/lib/libruby.2.6.dylib
endif
" theme -----------------------------------------------------------------------
if has("gui_running")
  colorscheme onedark
elseif $COLORTERM == 'gnome-terminal'
  set term=gnome-256color
  colorscheme ondedark
else
  colorscheme onedark
endif
set path+=**
" important -------------------------------------------------------------------
set nocompatible                                          "don't behave like VI
" moving around, searching and patterns ---------------------------------------
set incsearch                                 "shows search matches as you type
set showmatch                                          "shows matching brackets
set smartcase                                              "if caps, watch case
set ignorecase                                   "if all lowercase, ignore case
" tags ------------------------------------------------------------------------
set showfulltag             "when completing tags in Insert mode show more info
" displaying text -------------------------------------------------------------
set scrolloff=0               "number of screen lines to show around the cursor
set linebreak               " break words on spaces, usefull when textwidth set
set number                            "set line numbers. set nonu - turn it off
set sidescrolloff=0        "minimal number of columns to keep left and right of
                                                                    "the cursor
set listchars=tab:▸\ ,eol:¬,trail:·       "use the same symbols as TextMate for
                                                             "tabstops and EOLs
" syntax, highlighting and spelling -------------------------------------------
filetype on
filetype plugin on
filetype indent on
syntax on
set hlsearch                                         "highlights search results
highlight Pmenu ctermbg=238 gui=bold
highlight vertsplit ctermfg=black
"highlight NonText guifg=#4a4a59                    "invisible characters color
"highlight SpecialKey guifg=#4a4a59                 "invisible characters color
set spelllang=en                                    "list of accepted languages
"set spell                                         "highlight spelling mistakes
" multiple windows ------------------------------------------------------------
set laststatus=2                                       "always show status line
set hidden              "don't unload a buffer when no longer shown in a window
set splitbelow                       "a new window is put below the current one
" multiple tab pages ----------------------------------------------------------
" terminal --------------------------------------------------------------------
set title                                        "show info in the window title
" using the mouse -------------------------------------------------------------
set mouse=a                                         "enable mouse for all modes
" GUI -------------------------------------------------------------------------
set guifont=DejaVu\ Sans\ Mono:h12    "list of font names to be used in the GUI
set guioptions-=L                         "remove left-hand scrollbar in vsplit
set guioptions-=l                                   "remove left-hand scrollbar
set guioptions-=b                         "remove bottom (horizontal) scrollbar
set guioptions-=r                                  "remove right-hand scrollbar
set guioptions-=T                                               "remove toolbar
set guioptions-=m                                               "remove menubar
set guioptions-=e                                               "remove guitabs
" printing --------------------------------------------------------------------
" messages and info -----------------------------------------------------------
set showcmd                     "show (partial) command keys in the status line
set showmode                       "display the current mode in the status line
set ruler               "show the line and column number of the cursor position
set rulerformat=%30(%=%y\ %c,%l\ %P%)
set noerrorbells visualbell t_vb=                 "no beep, makes vim be silent
" selecting text --------------------------------------------------------------
" editing text ----------------------------------------------------------------
set undolevels=10000              "maximum number of changes that can be undone
set undofile                       "automatically save and restore undo history
set undodir=~/.vim/undo                     "list of directories for undo files
set undoreload=10000      "max number lines to save for undo on a buffer reload
set textwidth=80                       "line length above which to break a line
" tabs and indenting ----------------------------------------------------------
set tabstop=2                        "specifies the width of the tab charecters
set expandtab                "causes spaces to be used inplace of tab charaters
set softtabstop=2                           "number of spaces that 'Tab' counts
set shiftwidth=2         "number of spaces to use for each step of (auto)indent
"set ts=2 sts=2 sw=2 expandtab                                "default settings
" folding ---------------------------------------------------------------------
" diff mode -------------------------------------------------------------------
" mapping ---------------------------------------------------------------------
" reading and writing files ---------------------------------------------------
set autowriteall     "automatically write a file when leaving a modified buffer
" the swap file ---------------------------------------------------------------
set directory=~/.vim/swap                "list of directories for the swap file
set updatetime=250                        "time msec suggested by vim-gitgutter
" command line editing --------------------------------------------------------
set wildmode=list:longest          "specifies how command line completion works
set wildignore=*.o,*.obj,*~,.byebug_history,*.log
set wildignore+=vendor/ruby,vendor/assets,coverage,public/images,public/system,app/assets/images,tmp,bower_components,node_modules
set wildmenu
" executing external commands -------------------------------------------------
" running make and jumping to errors ------------------------------------------
" language specific -----------------------------------------------------------
" multi-byte characters
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
" various ---------------------------------------------------------------------
let mapleader=","
" mappings --------------------------------------------------------------------
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
"show invisible character
nmap <leader>l :set list!<CR>
"remove higlighting search
nmap <leader><space> :nohlsearch<CR>
"edit ~/.vimrc in new tab
nmap <leader>evrc :tabedit $MYVIMRC<CR>
nmap <leader>scs :tabedit $HOME/.vim-cheatsheet<CR>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
vnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
inoremap <down> <esc>
inoremap <left> <esc>
inoremap <right> <esc>
inoremap <up> <esc>
" abbreviations ---------------------------------------------------------------
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq
" autocmd settings ------------------------------------------------------------
if has("autocmd")
  autocmd BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
  autocmd BufNewFile,BufRead *.scss set filetype=sass
  autocmd BufNewFile,BufRead *.less set filetype=less
  autocmd BufNewFile,BufRead *.fbml.erb set filetype=eruby
  autocmd BufNewFile,BufRead *.json set filetype=json
  autocmd BufNewFile,BufRead *.(rdf|xml) set filetype=xml
  autocmd BufNewFile,BufRead *.prawn set ft=ruby
  autocmd BufNewFile,BufRead *.skim set ft=slim
  autocmd BufNewFile,BufRead /opt/nginx/conf/* set ft=nginx
  autocmd BufWritePre *.py,*.js,*.rb,*.coffee,*.erb,*.slim,*.skim,*.rake :call <SID>StripTrailingWhitespaces()
  "add spell checking and automatic wrapping at the recommended 72 columns to you commit messages.
  "https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
  autocmd Filetype gitcommit setlocal spell textwidth=72
  autocmd FileType nerdtree nmap <buffer> <leader>be :NERDTreeClose<CR>:BufExplorer<CR>
  autocmd FileType ruby setlocal keywordprg=ri "need to find option to set keywordprg only for buffer
  autocmd FileType ruby set omnifunc=syntaxcomplete#Complete "enable Omni compltetion
  autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  autocmd FileType ruby let g:rubycomplete_classes_in_global=1
  autocmd FileType ruby let g:rubycomplete_rails = 1
  autocmd FileType ruby let g:rubycomplete_load_gemfile = 1
  autocmd filetype crontab setlocal nobackup nowritebackup
endif
" functions -------------------------------------------------------------------
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
" plugins related -------------------------------------------------------------
" syntastic -------------------------------------------------------------------
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'passive_filetypes': ['sass', 'scss'] }
"disable syntastic in eruby
let g:syntastic_disabled_filetypes = ['eruby', 'slimrb']
let g:syntastic_html_tidy_ignore_errors = ['<ui-select> is not recognized!', '<ui-select-match> is not recognized!', '<ui-select-choices> is not recognized!', '<ui-select-no-choice> is not recognized!', '<sb-input> is not recognized!', '<sb-errors-list> is not recognized!', '<sb-errors-list> is not recognized!', '<sb-date-picker> is not recognized!', '<sb-select> is not recognized!', 'discarding unexpected <sb-errors-list>', 'discarding unexpected <sb-errors-list>', 'discarding unexpected </sb-errors-list>', 'discarding unexpected <sb-input>', 'discarding unexpected </sb-input>', 'discarding unexpected <sb-date-picker>', 'discarding unexpected </sb-date-picker>', '<sb-location-picker> is not recognized!']
" BufferExplorer --------------------------------------------------------------
let g:bufExplorerShowRelativePath=1                        "show relative paths
" NERDTree toggle -------------------------------------------------------------
map <silent> <leader>n :NERDTreeToggle<CR>
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=40
" command-t  ------------------------------------------------------------------
nmap <silent> <leader>tf :CommandTFlush<CR>
let g:CommandTMaxFiles = 55000
" ctags -----------------------------------------------------------------------
let Tlist_Ctags_Cmd='/opt/local/bin/ctags'                       "only for OS X
map <Leader>rt :!ctags --extra=+f -R * --exclude='*.js'<CR><CR>
" ack -------------------------------------------------------------------------
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Comment code
" ,#  -  shell, perl, etc
" ,/  -  c
" ,>  -  email quote
" ,"  -  vim
" ,%  -  latex, prolog
" ,!  -  assembly?... add single !
" ,;  -  scheme
" ,-  -  don't remember this one... add --
" ,c  -  clears any of the previous comments

" ,*  -  c
" ,(  -  Standard ML
" ,<  -  html
" ,d  -  clears any of the wrapping comments
" comments
map ,# :s/^/#/<CR>
map ,/ :s/^/\/\//<CR>
map ,> :s/^/> /<CR>
map ," :s/^/\"/<CR>
map ,% :s/^/%/<CR>
map ,! :s/^/!/<CR>
map ,; :s/^/;/<CR>
map ,- :s/^/--/<CR>
map ,cm :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>
" #" wrapping comments
map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>
map ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR>
map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>


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

