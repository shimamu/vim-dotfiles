scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" 参考:
"   :help gvimrc
"   :echo $HOME
"   :echo $VIM
"   :version

"--------画面表示--------
" カラーテーマ
"colorscheme planter
colorscheme cookle

" フォント
if has('win32')
  " Windows用
  set guifont=Consolas:h10 guifontwide=MeiryoKe_Gothic:h10
  " 行間隔の設定
  set linespace=4
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=Osaka－等幅:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif

"--------ウィンドウ--------
" ウインドウの幅
set columns=110

" ウインドウの高さ
set lines=50

" コマンドラインの高さ(GUI使用時)
set cmdheight=1

"タブを表示 0:常に非表示、1:2つ以上タブページがある場合に表示、2:常に表示
set showtabline=2

"--------日本語--------
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"--------マウス--------
" どのモードでもマウスを使えるようにする
set mouse=a

" マウスの移動でフォーカスを自動的に切替える (nomousefocus:切替えない)
set mousefocus

" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide

" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
set guioptions+=a

"--------印刷--------
"
" 注釈:
" 印刷はGUIでなくてもできるのでvimrcで設定したほうが良いかもしれない。この辺
" りはWindowsではかなり曖昧。一般的に印刷には明朝、と言われることがあるらし
" いのでデフォルトフォントは明朝にしておく。ゴシックを使いたい場合はコメント
" アウトしてあるprintfontを参考に。
"
" 参考:
"   :hardcopy
"   :help 'printfont'
"   :help printing
"
" 印刷用フォント
if has('printer')
  if has('win32')
    "set printfont=MS_Mincho:h12:cSHIFTJIS
    "set printfont=MS_Gothic:h12:cSHIFTJIS
    set printfont=MeiryoKe_Gothic:h10
  endif
endif
