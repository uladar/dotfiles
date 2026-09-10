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
  " Use the native Homebrew fzf when available; otherwise install the plugin.
  let g:brew_fzf = exists('$HOMEBREW_PREFIX') ? $HOMEBREW_PREFIX . '/opt/fzf' : ''
  if empty(g:brew_fzf) && executable('brew')
    let g:brew_fzf = trim(system('brew --prefix fzf 2>/dev/null'))
  endif
  if isdirectory(g:brew_fzf)
    " Fast fuzzy finder binary from native Homebrew.
    execute 'Plug ' . string(g:brew_fzf)
  else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fast fuzzy finder binary
  endif
  Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } } " Vim integration for fzf search commands
  Plug 'mileszs/ack.vim' " Search project files with ack or ag
  "Plug 'elixir-lang/vim-elixir' " Elixir syntax and tooling (disabled)
  "Plug 'fatih/vim-go' " Go language tooling (disabled)
  Plug 'pangloss/vim-javascript' " JavaScript syntax highlighting
  " Plug 'scrooloose/NERDTree' " Legacy file explorer (disabled; Neo-tree is used)
  "
  Plug 'jiangmiao/auto-pairs' " Automatically insert and close brackets and quotes
  "
  Plug 'joshdick/onedark.vim' " One Dark color scheme
  "
  Plug 'vim-airline/vim-airline' " Lightweight status line and tab line
  "
  Plug 'neovim/nvim-lspconfig' " LSP client configurations
  Plug 'airblade/vim-gitgutter' " Git diff markers in the sign column
  Plug 'tpope/vim-surround' " Add, change, and remove surrounding characters
  Plug 'tpope/vim-rails' " Rails-aware navigation and commands
  Plug 'tpope/vim-bundler' " Run Bundler commands from Vim
  Plug 'tpope/vim-endwise' " Automatically insert closing Ruby and Vimscript keywords
  Plug 'ap/vim-css-color' " Preview CSS color values
  Plug 'vim-scripts/tComment' " Toggle code comments
  Plug 'janko-m/vim-test' " Run project tests from Vim
  Plug 'pbrisbin/vim-mkdir' " Create missing directories when saving files
  Plug 'slim-template/vim-slim' " Slim template syntax and indentation
  Plug 'tpope/vim-rake' " Run Rake tasks from Vim
  Plug 'tpope/vim-rhubarb' " GitHub support for Fugitive-style workflows
  Plug 'vim-ruby/vim-ruby' " Ruby syntax, indentation, and completion helpers
  Plug 'ryanoasis/vim-devicons' " File type icons for Vim plugins and explorers
  " Plug 'vwxyutarooo/nerdtree-devicons-syntax' " NERDTree icon syntax (disabled with NERDTree)
  Plug 'coreyja/fzf.devicon.vim' " File icons in fzf results
  Plug 'kaicataldo/material.vim', { 'branch': 'main' } " Material color scheme
  "
  " --- Completion stack ---
  Plug 'hrsh7th/nvim-cmp' " Completion popup and completion engine
  Plug 'hrsh7th/cmp-nvim-lsp' " LSP completion source for nvim-cmp
  Plug 'hrsh7th/cmp-buffer' " Buffer text completion source
  Plug 'hrsh7th/cmp-path' " Filesystem path completion source
  Plug 'saadparwaiz1/cmp_luasnip' " LuaSnip completion source for nvim-cmp
  Plug 'L3MON4D3/LuaSnip' " Snippet engine
  " (optional) curated snippets:
  " Plug 'rafamadriz/friendly-snippets' " Community snippet collection (optional)
  "
  "
  Plug 'nvim-lua/plenary.nvim' " Lua utility library used by Neo-tree
  Plug 'MunifTanjim/nui.nvim' " UI component library used by Neo-tree
  Plug 'nvim-tree/nvim-web-devicons' " File type icons for Neo-tree
  Plug 'nvim-neo-tree/neo-tree.nvim' " File explorer and project tree
  "
  "Plug 'tpope/vim-eunuch' " Unix file commands (disabled)
  "Plug 'tpope/vim-fugitive' " Git commands inside Vim (disabled)
  "Plug 'tpope/vim-projectionist' " Project navigation by file type (disabled)
  "Plug 'tpope/vim-repeat' " Repeat plugin mappings with dot (disabled)

call plug#end()

" GENERAL -----------------------------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
" set termencoding=utf-8
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

lua require('user.keymaps')

set listchars=tab:▸\ ,eol:¬,trail:·         "use the same symbols as TextMate for
                                                               "tabstops and EOLs
" PLUGINS CONFIG ----------------------------------------------------------------
" ack
cnoreabbrev Ack Ack!
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" nerdtree toggle
" map <silent> <leader>n :NERDTreeToggle<CR>
" let g:NERDTreeWinPos="right"
" let g:NERDTreeWinSize=40

lua require('user.lsp')


" Recommended for cmp popup behavior
set completeopt=menu,menuone,noselect

lua << EOF
local cmp = require('cmp')
local luasnip = require('luasnip')

-- (optional) load VSCode-style snippets if you enabled friendly-snippets
-- require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>']      = cmp.mapping.confirm({ select = false }), -- Accept selected
    ['<C-e>']     = cmp.mapping.abort(),
    ['<Tab>']     = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { 'i', 's' }),
    ['<S-Tab>']   = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'luasnip' },
  },
  experimental = { ghost_text = false },
})
EOF

lua << EOF
require('neo-tree').setup({
  close_if_last_window = true,
  sources = { "filesystem", "buffers", "git_status" }, -- add "document_symbols" if you like
  filesystem = {
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
    filtered_items = { hide_dotfiles = false, hide_gitignored = true },
  },
  window = { width = 40 },
})
EOF


" SHRORCUTS ---------------------------------------------------------------------
" show invisible character
" strip trailing whitespaces
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
" nnoremap <M-P> :Files<cr> "TODO: map this to smth usefull

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
  "add spell checking and automatic wrapping at the recommended 72 columns to you commit messages.
  "https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
  autocmd FileType gitcommit setlocal spell textwidth=72
  " START """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
