
if exists("g:loaded_metaweblog")
    finish
end
let g:loaded_metaweblog = 1

scriptencoding utf-8

"let g:weblog_id       = 'rsrchboy'
"let g:weblog_password = 'XXXXXXXXXXXX'
"let s:api             = webapi#metaWeblog#proxy("http://wps.io/xmlrpc.php")
let s:api             = webapi#metaWeblog#proxy(g:weblog_url)

function! WPLoadPost()

    let l:post_data = s:api.getPost(392, g:weblog_id, g:weblog_password)

    botright split 392
    setl encoding=utf-8
    "tabnew
    "new
    let b:post_id = 392
    let b:post_data = l:post_data
    "call append(0, split(l:post_data['description'], "\x0"))
    call append(0, l:post_data['description'])

    execute "%s/[\x0]/\r/g"
    setl ft=markdown

endfunction

function! WPSavePost()

    "editPost(postid, username, password, content, publish) dict
    let l:success = s:api.editPost(b:post_id, g:weblog_id, g:weblog_password, {
                \   'description': join(getline(1, "$"), "\n"), 
                \ }, webapi#xmlrpc#false())

    let b:post_last_success = l:success

    if l:success
        echo "success!"
    else
        echo "FAIL!"
    end

endfunction

" vim:set ft=vim:
