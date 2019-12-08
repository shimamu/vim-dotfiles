scriptencoding utf-8
set encoding=utf-8

" General {{{
" Clipboard {{{
" When the Visual mode ends, possibly due to an operation on the text, or when
" an application wants to paste the selection, the highlighted text is 
" automatically yanked into the "* selection register.
set guioptions+=a
" }}}
" Mouse {{{
" Enable the use of the mouse.
set mouse=a

" The window that the mouse pointer is on is automatically activated.
set mousefocus

" When on, the mouse pointer is hidden when characters are typed.
set mousehide

" }}}
" }}}
" Screen {{{
" Font {{{
if has('win32')
  " This is a list of fonts which will be used for the GUI version of Vim.
  set guifont=Consolas:h10 guifontwide=MeiryoKe_Gothic:h10
  " Number of pixel lines inserted between characters.
  set linespace=4
  if has('kaoriya')
    set ambiwidth=auto
  endif
endif
" }}}
" }}}
" Window {{{
" Number of columns of the screen.
set columns=110

" Number of lines of the Vim window.
set lines=50

" Number of screen lines to use for the command-line.
set cmdheight=1

" The value of this option specifies when the line with tab page labels
" will be displayed:
"     0: never
"     1: only if there are at least two tab pages
"     2: always
set showtabline=2

" }}}
" Printing {{{
" see:
"   :hardcopy
"   :help 'printfont'
"   :help printing
if has('printer')
  if has('win32')
    " The name of the font that will be used for |:hardcopy|.
    "set printfont=MS_Mincho:h12:cSHIFTJIS
    "set printfont=MS_Gothic:h12:cSHIFTJIS
    set printfont=MeiryoKe_Gothic:h10
  endif
endif
" }}}

" vim:set ts=8 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker:
