" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible



set nocompatible              " be iMproved, required
filetype off                  " required

"do pathogen stuff to use plugins
execute pathogen#infect()

"==================== SYNTASTIC SETTINGS

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"==================== END OF SYNTASTIC

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

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
"if filereadable("/etc/vim/vimrc.local")
"  source /etc/vim/vimrc.local
"endif


"if $TERM == "xterm-256color"
"  set t_Co=256
"endif


"set colorscheme to evening
:colorscheme evening

"==================== START OF LINE NUMBER STUFF ============
set relativenumber

function! NumberToggle()
  if(&relativenumber == 1)
    set number
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


set nowrap

"==================== STUFF FOR SEARCHING ==================

:nnoremap <CR> :nohlsearch<CR><CR>
:set hlsearch
"highlight text when searching
:hi Search guibg=LightBlue


"==================== AIRLINE ==============================
"make airline start when a file is opened
set laststatus=2  
"this makes the cool tab info on top appear
let g:airline#extensions#tabline#enabled = 1
"hide default mode
set noshowmode
"==================== END OF AIRLINE =======================

"let g:ycm_server_python_interpreter = '/usr/bin/python3'
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion=1
"let g:ycm_python_binary_path = 'python3'

"==================== FILETYPE SETTINGS ====================
"treat handlebars and ejs files like html for formatting
au BufNewFile,BufRead *.handlebars set filetype=html
au BufNewFile,BufRead *.ejs set filetype=html
