" ~  VIM CONFIGURATION FOR SYSADMINS ~
"
" "
" =============================================================================
" 1. APPEARANCE AND COLORS
" =============================================================================
syntax on            " Enable syntax highlighting
set number           " Show line numbers
set relativenumber   " Show relative numbers for easier movement
set ruler            " Always show cursor position
set showcmd          " Show partial commands in the last line
set wildmenu         " Visual autocomplete for command-line commands
set cursorline       " Highlight the current line
set termguicolors    " Enable 24-bit RGB color
"
" Set the color scheme after the plugins are loaded (see section 4)
" If you have issues, you can temporarily use a built-in one like 'desert'
" colorscheme desert
"

" =============================================================================
" 2. EDITOR BEHAVIOR
" =============================================================================
" Set spacebar as leader key
let mapleader = " "

set history=1000     " Remember more commands and search history
set mouse=a          " Enable mouse support in all modes
filetype plugin indent on " Load filetype-specific indentations and plugins
"
" Searching
set incsearch        " Find the next match as you type
set hlsearch         " Highlight all other matches
set ignorecase       " Ignore case in search patterns...
set smartcase        " ...unless you type a capital letter
"
" Tabs and Indentation
set tabstop=4        " Number of visual spaces per tab
set softtabstop=4    " Number of spaces for tab key
set shiftwidth=4     " Number of spaces for indentation
set expandtab        " Use spaces instead of tabs
set autoindent       " Copy indent from current line when starting a new one
"
" Key Mappings
inoremap jj <Esc>    " Use jj to exit insert mode
"

" =============================================================================
" 3. PLUGIN MANAGER (vim-plug)
" =============================================================================
" Automatically install vim-plug if it's not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - For Vim:    ~/.vim/plugged
call plug#begin('~/.vim/plugged')
"

" =============================================================================
" 4. PLUGINS LIST
" =============================================================================
" For a modern, readable color scheme with pleasant contrast.
Plug 'joshdick/onedark.vim'

" For a retro groove color scheme with great contrast
Plug 'morhetz/gruvbox'

" For lightning-fast navigation with just a few keystrokes.
Plug 'easymotion/vim-easymotion'

" For jumping to any location specified by two characters.
Plug 'justinmk/vim-sneak'

" A nice status line at the bottom
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Automatically add closing brackets, parentheses, quotes, etc.
Plug 'Raimondi/delimitMate'

" Easy commenting and uncommenting with gcc, gc, etc.
Plug 'tpope/vim-commentary'

" For seamless tmux integration from vim
Plug 'preservim/vimux'

" Initialize the plugin system
call plug#end()
"

" =============================================================================
" 5. APPLY PLUGIN CONFIGURATIONS
" =============================================================================
" Color scheme options - choose one:
" Option 1: OneDark (modern, readable)
" colorscheme onedark

" Option 2: Gruvbox (retro groove, warm colors)
" Uncomment the lines below and comment out onedark to use gruvbox
set background=dark    " or set background=light for light variant
colorscheme gruvbox
"
" To quickly switch between schemes, you can use:
" :colorscheme onedark
" :colorscheme gruvbox
"

" =============================================================================
" 6. VIMUX HELPER FUNCTIONS
" =============================================================================
" Run current line in tmux pane
function! VimuxRunCurrentLine()
  let current_line = getline('.')
  call VimuxRunCommand(current_line)
endfunction

" Run current line + N lines below
function! VimuxRunLinesBelow(count)
  let lines = getline('.', line('.') + a:count)
  let command = join(lines, "\n")
  call VimuxRunCommand(command)
endfunction

" Run current line + N lines above
function! VimuxRunLinesAbove(count)
  let lines = getline(line('.') - a:count, '.')
  let command = join(lines, "\n")
  call VimuxRunCommand(command)
endfunction

" Run current line + N lines above and below
function! VimuxRunLinesAround(count)
  let lines = getline(line('.') - a:count, line('.') + a:count)
  let command = join(lines, "\n")
  call VimuxRunCommand(command)
endfunction

" Run visual selection in tmux pane
function! VimuxRunSelection()
  let lines = getline("'<", "'>")
  let command = join(lines, "\n")
  call VimuxRunCommand(command)
endfunction

" Vimux operator function
function! VimuxOperator(type)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@
  
  if a:type == 'line'
    '[,']yank
  elseif a:type == 'char'
    '`[,`]yank
  else
    return
  endif
  
  let command = @@
  let &selection = sel_save
  let @@ = reg_save
  
  call VimuxRunCommand(command)
endfunction

" =============================================================================
" 7. VIMUX KEY MAPPINGS
" =============================================================================
" Single line execution
nnoremap <Leader><Leader>vl :call VimuxRunCurrentLine()<CR>

" Operator-pending mode for flexible selection
nnoremap <Leader><Leader>v :set operatorfunc=VimuxOperator<CR>g@

" Direct multi-line execution (traditional way)
nnoremap <Leader><Leader>vj :<C-u>call VimuxRunLinesBelow(v:count1 == 1 ? 3 : v:count1)<CR>
nnoremap <Leader><Leader>vk :<C-u>call VimuxRunLinesAbove(v:count1 == 1 ? 3 : v:count1)<CR>
nnoremap <Leader><Leader>va :<C-u>call VimuxRunLinesAround(v:count1 == 1 ? 3 : v:count1)<CR>

" Paragraph execution (blank line separated)
nnoremap <Leader><Leader>vp vip:call VimuxRunSelection()<CR>

" Visual selection execution
vnoremap <Leader><Leader>vv :call VimuxRunSelection()<CR>

" Quick Vimux commands
nnoremap <Leader><Leader>vr :VimuxRunLastCommand<CR>
nnoremap <Leader><Leader>vc :VimuxCloseRunner<CR>
nnoremap <Leader><Leader>vi :VimuxInspectRunner<CR>
"
