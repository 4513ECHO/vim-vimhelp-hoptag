let b:did_ftplugin = v:true

" NOTE: pattern is from $VIMRUNTIME/syntax/help.vim
let s:tag_pattern = [
      \ '\\\@<!|[#-)!+-~]\+|', '\*[#-)!+-~]\+\*\s', '\*[#-)!+-~]\+\*$',
      \ "'[a-z]\\{2,\\}'", "'t_..'",
      \ '<[-a-zA-Z0-9_]\+>', '<[SCM]-.>',
      \ 'CTRL-.', 'CTRL-SHIFT-.', 'CTRL-Break', 'CTRL-PageUp', 'CTRL-PageDown',
      \ 'CTRL-Insert', 'CTRL-Del', 'CTRL-{char}',
      \ ]->join('\|')

function! s:hop_tag(direction) abort
  let flags = (a:direction ? '' : 'b') .. 'W'
  call range(v:count1)->map({ -> search(s:tag_pattern, flags, 0, 500) })
endfunction

nnoremap <buffer> <Plug>(hoptag-next) <Cmd>call <SID>hop_tag(1)<CR>
nnoremap <buffer> <Plug>(hoptag-prev) <Cmd>call <SID>hop_tag(0)<CR>
