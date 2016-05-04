scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" 参考:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version

"--------基本設定--------
" plugins下のディレクトリをruntimepathへ追加する。
if has('win32')
  for s:path in split(glob($VIM.'/plugins/*'), '\n')
    if s:path !~# '\~$' && isdirectory(s:path)
      let &runtimepath = &runtimepath.','.s:path
    end
  endfor
  unlet s:path
endif

"--------OS別の設定--------
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
if has('win32')
  source $VIM/plugins/kaoriya/encode_japan.vim
endif

" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
if !(has('win32') || has('mac')) && has('multi_lang')
  if !exists('$LANG') || $LANG.'X' ==# 'X'
    if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
      language ctype ja_JP.eucJP
    endif
    if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
      language messages ja_JP.eucJP
    endif
  endif
endif

" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
if has('mac')
  set langmenu=japanese
endif

" 非GUI日本語コンソールを使っている場合の設定
if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
  set termencoding=cp932
endif

" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let s:uname = system('uname')
  if s:uname =~? "linux"
    set term=builtin_linux
  elseif s:uname =~? "freebsd"
    set term=builtin_cons25
  elseif s:uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet s:uname
endif

" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

" Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
if has('mac')
  set iskeyword=@,48-57,_,128-167,224-235
endif

"--------検索--------
" 検索時に大文字小文字を無視
set ignorecase

" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

" ファイルの最後まで検索したら最初に戻る (nowrapscan:戻らない)
set wrapscan

" 検索後のハイライトクリアのマッピング。
nnoremap <silent> <C-l> :nohl<CR><C-l>

"--------画面表示--------
" タブの画面上での幅
set tabstop=4

" autoindentでインデントされる幅
set shiftwidth=4

" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab

" 自動的にインデントする (noautoindent:インデントしない)
set autoindent

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch

" 行番号を表示
set number

" ルーラーを表示
set ruler

" タブや改行を表示
set list

" どの文字でタブや改行を表示するかを設定
"set listchars=tab:\|\ ,extends:<,trail:-,eol:$
set listchars=tab:▸\ ,extends:<,trail:-,eol:¬

" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap

" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2

" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=1

" コマンドをステータス行に表示
set showcmd

" タイトルを表示
set title

" 行を強調表示
set cursorline

" 検索後のハイライトを画面再描画時に消す。
nnoremap <silent> <C-L> :noh<C-L><CR>

"--------編集--------
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

" 自動補完登録
source ~/vimfiles/abbreviate.vim

"--------システム--------
" バックアップファイルを作成しない
set nobackup

" undofile 「.{ファイル名}.un~」を出力しないように修正。
:set noundofile

" スワップファイルの保存場所の指定。
if has('win32')
  set directory=~/tmp
elseif has('unix')
  set directory=~/.vim/tmp
endif

"--------KaoriYa プラグイン--------
" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
if has('win32')
  set formatexpr=autofmt#japanese#formatexpr()
endif

" vimdoc-ja: 日本語ヘルプを無効化する.
if has('win32')
  if kaoriya#switch#enabled('disable-vimdoc-ja')
    let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimdoc-ja"'), ',')
  endif
endif

" vimproc: 同梱のvimprocを無効化する
if has('win32')
  if kaoriya#switch#enabled('disable-vimproc')
    let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimproc$"'), ',')
  endif
endif

"--------lightline.vim 設定--------
let g:lightline = { 'colorscheme': 'nighted' }
"let g:lightline = {
"        \ 'colorscheme': 'landscape',
"	\ }

"--------NeoBundle プラグイン--------
if has('vim_starting')
  set nocompatible               " be iMproved

  set runtimepath+=~/vimfiles/bundle/neobundle.vim
endif
" Required:
call neobundle#rc(expand('~/vimfiles/bundle/'))

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
"NeoBundle 'mattn/webapi-vim'
"NeoBundle 'vimtaku/vim-mlh'
"NeoBundle 'VimClojure'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'Shougo/neosnippet'
"NeoBundle 'jpalardy/vim-slime'
"NeoBundle 'scrooloose/syntastic'
""NeoBundle 'https://bitbucket.org/kovisoft/slimv'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'nathanaelkane/vim-indent-guides'
" これを使うと手動で改行したときにインデントしないものもある。
" 下の pangloss/vim-javascript を使う。
"NeoBundle 'vim-scripts/JavaScript-Indent'
NeoBundle 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
"NeoBundle 'majutsushi/tagbar'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Chiel92/vim-autoformat'

filetype plugin indent on     " required!

NeoBundleCheck

"--------ファイルタイプ毎の設定--------
" Ruby
au BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2

" HTML
au BufNewFile,BufRead *.html  set nowrap tabstop=2 shiftwidth=2

" javascript
au BufNewFile,BufRead *.js  noremap <silent> = :Autoformat<CR>

