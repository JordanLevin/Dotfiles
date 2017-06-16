" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible



set nocompatible              " be iMproved, required
filetype off                  " required


call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'valloric/youcompleteme'
"Plug 'Shougo/neocomplete.vim'
Plug 'tpope/vim-surround'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'eagletmt/neco-ghc'
Plug 'wellle/targets.vim'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'sirver/ultisnips'
Plug 'jiangmiao/auto-pairs'
Plug 'severin-lemaignan/vim-minimap'

call plug#end()



"use global clipboard
set clipboard=unnamedplus

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

"==================== SNIPPET SETTINGS =====================

let g:UltiSnipsExpandTrigger="<c-w>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"==================== SYNTASTIC SETTINGS ===================

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"==================== END OF SYNTASTIC ======================
"
" Enable syntax highlighting
if has("syntax")
  syntax on
endif

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set autowrite		" Automatically save before commands like :next and :make
"set mouse=a		" Enable mouse usage (all modes)

"if $TERM == "xterm-256color"
"  set t_Co=256
"endif

"set colorscheme to evening
:colorscheme evening

"==================== MISC KEY MAP SETTINGS =================

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor


"==================== MISC SETTINGS =========================

set nowrap
set hidden		" Hide buffers when they are abandoned
set incsearch		" Incremental search
set showmatch		" Show matching brackets.
set showcmd		" Show (partial) command in status line.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " disable auto commenting

"==================== START OF LINE NUMBER STUFF ============
set relativenumber
set number
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

"==================== START OF TAB STUFF ====================

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
"makes a backspace delete a tab made of 4 spaces
set softtabstop=4

"set a bunch of autotab things
set autoindent
set smartindent
set cindent


"==================== STUFF FOR SEARCHING ==================

:nnoremap <CR> :nohlsearch<CR><CR>
:set hlsearch
"highlight text when searching
:hi Search guibg=LightBlue


"==================== AIRLINE ==============================
"make airline start when a file is opened
set laststatus=2  
"set theme
"set AirlineTheme 
let g:airline_powerline_fonts = 1
"this makes the cool tab info on top appear
let g:airline#extensions#tabline#enabled = 1
"hide default mode
set noshowmode
"==================== END OF AIRLINE =======================

"==================== YCM SETTINGS =========================
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_server_python_interpreter = '/usr/bin/python3'
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = ">"
let g:ycm_python_binary_path = '/usr/bin/python3'
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion=1
"let g:ycm_python_binary_path = 'python3'

"=================== END OF YCM SETTINGS ===================

"==================== FILETYPE SETTINGS ====================
"treat handlebars and ejs files like html for formatting
au BufNewFile,BufRead *.handlebars set filetype=html
au BufNewFile,BufRead *.ejs set filetype=html

"make vim transparent
hi Normal ctermbg=none
