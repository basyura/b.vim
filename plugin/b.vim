
command! B  call <SID>Blist()
command! BA  call <SID>BAdd()

function! s:Blist()
    " 新しいタブを開く
    tabnew
    " ブックマークのリストを読み込む
    exe "read ~/.vim/plugin/b/plugin/btags"
    " Enter 押下時に B_Jump を呼ぶ
    noremap <Enter> :call B_Jump()<cr>
    " 変更を受け付けたことにする
	set nomodified
    " 変更させない
	set nomodifiable
endfunction

function! s:BAdd() 
    let path = expand("%:p:h")
    exe "redir! >> ~/.vim/plugin/b/plugin/btags"
    silent echo path
    silent redir END
    echo "add " . path
endfunction

function! B_Jump()
    let path = getline(".")
    if path != ""
        execute "e! " . getline(".")
        noremap <Enter> <Enter>
    end
endfunction

