if exists('g:loaded_split_duplicator')
    finish
endif
let g:loaded_split_duplicator = 1

" Set default mappings if user hasn't defined custom ones
if !exists('g:split_duplicator_no_mappings')
    " Default mappings
    if !hasmapto('<Plug>SplitDuplicatorDuplicate')
        nmap <Leader>ds <Plug>SplitDuplicatorDuplicate
        vmap <Leader>ds <Plug>SplitDuplicatorDuplicate
    endif

    if !hasmapto('<Plug>SplitDuplicatorWezTerm')
        nmap <Leader>wt <Plug>SplitDuplicatorWezTerm
        vmap <Leader>wt <Plug>SplitDuplicatorWezTerm
    endif
endif

" Define plugin mappings
nnoremap <silent> <Plug>SplitDuplicatorDuplicate :call split_duplicator#duplicate_to_split(0)<CR>
vnoremap <silent> <Plug>SplitDuplicatorDuplicate :<C-U>call split_duplicator#duplicate_to_split(0)<CR>
nnoremap <silent> <Plug>SplitDuplicatorWezTerm :call split_duplicator#open_in_wezterm(5)<CR>
vnoremap <silent> <Plug>SplitDuplicatorWezTerm :<C-U>call split_duplicator#open_in_wezterm(0)<CR>

" Commands
command! -nargs=? -range DuplicateToSplit <line1>,<line2>call split_duplicator#duplicate_to_split(<q-args> == '' ? 0 : <q-args>)
command! -nargs=? -range OpenInWezTerm <line1>,<line2>call split_duplicator#open_in_wezterm(<q-args> == '' ? 0 : <q-args>)
