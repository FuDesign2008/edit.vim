"
" openUrl.vim
"
" available for windows, mac, unix/linux
"
" 1. Open the url under the cursor: <leader>u
" 2. Open the github bundle under the cursor: <leader>b
"
"



if &compatible || exists(':Edit')
    finish
endif
let s:save_cpo = &cpoptions
set cpoptions&vim


function! s:EditFolder()
    let folder = expand('%:p:h')
    execute ':e ' . folder
endfunction

function! s:EditFile(fileName)
    let folder = expand('%:p:h')
    let filePath = folder . '/' . a:fileName
    if filereadable(filePath)
        execute ':e ' . filePath
    else
        echoerr 'Failed to find file: ' . filePath
    endif
endfunction

function! s:RelativeEdit(...)
    let argsCount = a:0
    if argsCount == 0
        call s:EditFolder()
    else
        let fileName = a:1
        if fileName ==# '.'
            call s:EditFolder()
        else
            call s:EditFile(fileName)
        endif
    endif
endfunction



" :Edit {fileName}
command! -nargs=? -complete=file Edit call s:RelativeEdit(<f-args>)

let &cpoptions = s:save_cpo
