" NOTE: pattern is from $VIMRUNTIME/syntax/help.vim
let s:tag_pattern = [
      "\ link
      \ '\\\@<!|[#-)!+-~]\+|',
      "\ option
      \ "'[a-z]\\{2,\\}'", "'t_..'",
      "\ key notation
      \ '<[-a-zA-Z0-9_]\+>', '<[SCM]-.>', 'CTRL-\%(SHIFT-\)\?.',
      \ 'CTRL-\%(Break\|PageUp\|PageDown\|Insert\|Del\|{char}\)',
      \ ]->join('\|')

function! s:search(flags) abort
  call search(s:tag_pattern, a:flags, 0, 500,
        \ { -> synID(line('.'), col('.'), 1)->synIDattr('name') ==# 'helpExample' ||
        \   (has('nvim') && luaeval('vim.treesitter.get_captures_at_cursor()') ==# ['text.literal.block'])
        \ })
endfunction

function! s:hop_tag(direction) abort
  let flags = (a:direction ? '' : 'b') .. 'W'
  call range(v:count1)->map({ -> s:search(flags) })
endfunction

nnoremap <buffer> <Plug>(hoptag-next) <Cmd>call <SID>hop_tag(1)<CR>
nnoremap <buffer> <Plug>(hoptag-prev) <Cmd>call <SID>hop_tag(0)<CR>
