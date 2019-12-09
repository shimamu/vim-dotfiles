scriptencoding utf-8
set encoding=utf-8

" Vundle plugins {{{
" Pre-process {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" }}}
" Plugins {{{
" Keep Plugin commands between vundle#begin/end.
" Plugins for markdown {{{
Plugin 'tpope/vim-markdown'
Plugin 'kannokanno/previm'
Plugin 'tyru/open-browser.vim'
if has('win32')
  let g:previm_disable_default_css = 1
  let g:previm_custom_css_path = '~/.vim/css/markdown.css'
endif
" }}}
" Plugin for configurable status line {{{
Plugin 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'PaperColor_light',
      \ 'active': {
      \    'left': [['mode', 'paste'], ['readonly', 'filename', 'modified', 'fixMode']]
      \ },
      \ 'component_function': {
      \   'fixMode': 'FixModeStatus'
      \ }
      \ }
function! FixModeStatus()
  return IMStatus('Jpfix')
endfunction
" }}}
" Plugin for controling Input Method {{{
Plugin 'fuenor/im_control.vim'
if has('win32')
  " Action mode for 'Japanese input fixed mode'
  let IM_CtrlMode = 4
  " Key mapping for 'Japanese input fixed mode'
  inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
elseif has('unix')
  " Action mode for 'Japanese input fixed mode'
  let IM_CtrlMode = 1
  " Key mapping for 'Japanese input fixed mode'
  inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
  " after IBus 1.5
  function! IMCtrl(cmd)
    let cmd = a:cmd
    if cmd == 'On'
      let res = system('ibus engine "mozc-jp"')
    elseif cmd == 'Off'
      let res = system('ibus engine "xkb:jp::jpn"')
    endif
    return ''
  endfunction
endif
" }}}
" Plugin for file system explorer {{{
Plugin 'scrooloose/nerdtree'
" Customize <CR> to remain in tree window after opening.
let NERDTreeCustomOpenArgs={'file': {'where': 'p', 'stay': 1}, 'dir': {}}
" }}}
" }}}
" Post-process {{{
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}
" }}}
" General {{{
" Cursor {{{

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" Highlight the screen line of the cursor with CursorLine |hl-CursorLine|.
set cursorline

" }}}
" Backup {{{

" Do not make a backup before overwriting a file.
set nobackup

" }}}
" History {{{

" When on, Vim automatically saves undo history to an undo file when
" writing a buffer to a file, and restores undo history from the same
" file on buffer read.
:set noundofile

" }}}
" Swap file {{{

" List of directory names for the swap file, separated with commas.
if has('win32')
  set directory=~/tmp
elseif has('unix')
  set directory=~/.vim/tmp
endif

" }}}
" Runtime path {{{
" Add .vim directories to runtimepath.
if has('win32')
  set runtimepath+=$HOME/.vim,$HOME/.vim/after
endif
" }}}
" Backspace {{{
" Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
set backspace=indent,eol,start
" }}}
" }}}
" Screen {{{
" Layout {{{
" Window wrapping {{{

" Lines longer than the width of the window will wrap and displaying
" continues on the next line.
set wrap

"}}}
" Text wrapping {{{

" Maximum width of text that is being inserted.
set textwidth=80

" Apply text wrapping to Japanese.
set formatoptions+=mM

" }}}
" Tab {{{
"
" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4

" Number of spaces that a <Tab> counts for while performing editing
" operations, like inserting a <Tab> or using <BS>.
set softtabstop=0

" Use the appropriate number of spaces to insert a <Tab>.
set expandtab

"}}}
" Non-display characters {{{

" Show tabs as CTRL-I is displayed, display $ after end of line.
set list

" Strings to use in 'list' mode and for the :list command.
set listchars=tab:\|\ ,extends:<,trail:-,eol:$

" }}}
" Characters with East Asian Width Class Ambiguous {{{
" Only effective when 'encoding' is "utf-8" or another Unicode encoding.
" Tells Vim what to do with characters with East Asian Width Class
" Ambiguous).
"     There are currently two possible values:
"     "single": Use the same width as characters in US-ASCII.  This is
"               expected by most users.
"     "double": Use twice the width of ASCII characters.
set ambiwidth=double
" }}}
" }}}
" Indentng {{{

" Copy indent from current line when starting a new line (typing <CR>
" in Insert mode or when using the "o" or "O" command).
set autoindent

" }}}
" }}}
" Color {{{
 
" When this option is set, the syntax with this name is loaded.
syntax on

" Color scheme.
colorscheme ithd

" }}}
" Window {{{
" Title {{{

" When on, the title of the window will be set to the value of
" 'titlestring' (if it is not empty), or to:
"        filename [+=-] (path) - VIM
set title

" }}}
" Line number {{{

" Print the line number in front of each line.
set number

" }}}
" Status line {{{
" Basic {{{

" The value of this option influences when the last window will have
" a status line:
"     2: always
set laststatus=2

" }}}
" Ruler {{{

" Show the line and column number of the cursor position.
set ruler

" }}}
" }}}
" Command line {{{

" Number of screen lines to use for the command-line.
" * Use gvimrc when using gvim in Windows.
set cmdheight=1

" Show (partial) command in the last line of the screen.
set showcmd

" When 'wildmenu' is on, command-line completion operates in an
" enhanced mode.
set wildmenu

" }}}
" }}}
" Search {{{

" While typing a search command, show where the pattern, as it was typed so far,
" matches.  The matched string is highlighted.  If the pattern
set incsearch

" When there is a previous search pattern, highlight all its matches.
set hlsearch

" Ignore case in search patterns.
set ignorecase

" Override the 'ignorecase' option if the search pattern contains
" upper case characters.
set smartcase

" Searches wrap around the end of the file.
set wrapscan

" }}}
" Key mapping {{{

" Stop the highlighting for the 'hlsearch' option.
nnoremap <silent> <C-l> :noh<CR><C-l>

" }}}
" Abbreviate {{{
source ~/.vim/abbreviate.vim
" }}}
" Filetypes {{{
" HTML {{{

au BufNewFile,BufRead *.html  set nowrap tabstop=2 shiftwidth=2

" }}}
" Javascript {{{

au BufNewFile,BufRead *.js  noremap <silent> = :Autoformat<CR>

" }}}
" Markdown {{{

" Open current buffer in browser.
au BufNewFile,BufRead *.md nnoremap <silent> <C-p> :PrevimOpen<CR>

" }}}
" Ruby {{{

au BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2

" }}}
" }}}

" vim:set ts=8 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker:
