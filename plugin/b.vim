scriptencoding utf-8
" b.vim
" Author : basyura <basyura@gmail.com>
" version: $Id$
" 
" :B 
"    ブックマークリストを表示
"    ブックマークリストで Enter を押すと netrw で表示
" :BA 
"    ブックマークリストにパスを追加
" :BE 
"    ブックマークリストを編集
"

command! B   call <SID>Blist()
command! BA  call <SID>BAdd()
command! BE  call <SID>BEdit()
" ブックマークリストの保存先
let s:btags_path = expand('<sfile>:p:h') . "/btags"
" ファイルを読み込めない場合
if !filereadable(s:btags_path)
    " ファイルを生成する
    exe "redir! > " . s:btags_path
    silent echon "----------------------------------"
    silent echo  "BookMark"
    silent echo  "----------------------------------"
    silent echo  ""
    silent redir END
endif
"
" ブックマークのリストを表示
"
function! s:Blist()
    " 新しいタブを開く
    tabnew
    " ブックマークのリストを読み込む
    exe "read " . s:btags_path
    " Enter 押下時に B_Jump を呼ぶ
    noremap <Enter> :call B_Jump()<cr>
    " 変更を受け付けたことにする
	set nomodified
    " 変更させない
	"set nomodifiable
endfunction
"
" ブックマークのリストに追加
"
function! s:BAdd() 
    " 追加するパス
    let path = expand("%:p:h")
    " 出力先をファイルに
    exe "redir! >> " . s:btags_path
    " パスを出力
    silent echo path
    " 出力終了
    silent redir END
    " メッセージ
    echo "add " . path
endfunction
"
" ブックマークリストを編集
"
function! s:BEdit()
    exe "tabnew " . s:btags_path
endfunction
"
" ブックマークリストで Enter 押下時に呼び出される
" カレント行のパスを netrw で表示
"
function! B_Jump()
    " カレントの行を取得
    let path = getline(".")
    " ディレクトリの場合
    if isdirectory(path)
        " 編集開始
        execute "e! " . getline(".")
        " マップを戻す
        noremap <Enter> <Enter>
    else
        " ディレクトリでない場合はメッセージ通知
        echo path . " is not directory"
    endif
endfunction

