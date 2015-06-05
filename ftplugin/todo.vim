function! s:ExecuteKeepingCursorPosition(command)
  let l:saved_search_pattern = @/
  let l:saved_line = line('.')
  let l:saved_column = col('.')

  execute a:command

  let @/ = l:saved_search_pattern
  call cursor(l:saved_line, l:saved_column)
endfunction

function! s:ChangeTaskStatus(new_status)
  let l:marker_pattern = '\<\(TODO\|INPROGRESS\|HOLD\|DONE\)\>'
  let l:old_status = matchstr(getline('.'), l:marker_pattern)

  if len(l:old_status) == 0 || l:old_status == a:new_status
    echo ''
    return
  endif

  silent! call <SID>ExecuteKeepingCursorPosition('s/'.l:marker_pattern.'/'.a:new_status)
  silent! write

  echo "Task updated: " . l:old_status . " -> " . a:new_status
endfunction

nnoremap <silent> <Plug>(vim-simple-task-manager-new-task)          :normal oTODO <CR>a
nnoremap <silent> <Plug>(vim-simple-task-manager-status-todo)       :call <SID>ChangeTaskStatus('TODO')<CR>
nnoremap <silent> <Plug>(vim-simple-task-manager-status-progress)   :call <SID>ChangeTaskStatus('INPROGRESS')<CR>
nnoremap <silent> <Plug>(vim-simple-task-manager-status-hold)       :call <SID>ChangeTaskStatus('HOLD')<CR>
nnoremap <silent> <Plug>(vim-simple-task-manager-status-done)       :call <SID>ChangeTaskStatus('DONE')<CR>

if get(g:, 'simple_task_manager#disable_default_mappings')
  finish
endif

nmap <buffer> <leader>tn   <Plug>(vim-simple-task-manager-new-task)
nmap <buffer> <leader>tt   <Plug>(vim-simple-task-manager-status-todo)
nmap <buffer> <leader>tp   <Plug>(vim-simple-task-manager-status-progress)
nmap <buffer> <leader>th   <Plug>(vim-simple-task-manager-status-hold)
nmap <buffer> <leader>td   <Plug>(vim-simple-task-manager-status-done)
