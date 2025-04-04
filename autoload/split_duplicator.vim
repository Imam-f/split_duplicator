" Function to duplicate either current line +/- n lines or visual selection to a split window
" The split direction is determined by window dimensions (vertical if width > height)
" Opens the same buffer in the new split
function! split_duplicator#duplicate_to_split(count) range
    " Store current position
    let curpos = getpos('.')
    let curline = line('.')

    " Determine if in visual mode
    let is_visual = a:firstline != a:lastline

    " Determine start and end lines
    if is_visual
        let start_line = a:firstline
        let end_line = a:lastline
    else
        let start_line = max([1, curline - a:count])
        let end_line = min([line('$'), curline + a:count])
    endif

    " Determine split direction based on window dimensions
    let win_width = winwidth(0)
    let win_height = winheight(0)

    " Create split with same buffer (vertical if width > height)
    if win_width > 2*win_height
        execute 'vsplit'
    else
        execute 'split'
    endif

    " Move cursor to the appropriate line in the new window
    if is_visual
        execute start_line
        normal! zt
    else
        execute curline
        normal! zz
    endif
endfunction

" Function to open current file in wezTerm, focusing on specific lines with auto-reload
function! split_duplicator#open_in_wezterm(count) range
    " Store current position and file information
    let curpos = getpos('.')
    let curline = line('.')
    let current_file = expand('%:p')

    " Ensure we have an absolute path
    if current_file == ''
        echohl ErrorMsg
        echo "Current buffer must be saved to a file first"
        echohl None
        return
    endif

    " Determine if in visual mode
    let is_visual = a:firstline != a:lastline

    " Determine start and end lines
    if is_visual
        let start_line = a:firstline
        let end_line = a:lastline
    else
        let start_line = max([1, curline - a:count])
        let end_line = min([line('$'), curline + a:count])
    endif

    " Construct Vim command string with multiple -c options
    let vim_cmds = [
                \ '-c "set nomodifiable readonly autoread updatetime=1000"',
                \ '-c "autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * checktime"',
                \ '-c "let v:swapchoice = \"o\""',
                \ '-c "TSContextDisable"',
                \ '-c "normal! ' . start_line . 'G"',
                \ '-c "normal! zt"'
                \ ]

    " Add Vim/Neovim command
    let editor_cmd = get(g:, 'split_duplicator_editor', executable('nvim') ? 'nvim' : 'vim')
    let vim_cmd = editor_cmd . ' ' . join(vim_cmds, ' ') . ' ' . shellescape(current_file)

    " Create wezTerm command
    let wezterm_cmd = get(g:, 'split_duplicator_terminal', 'wezterm start --')

    " Execute the wezTerm command
    let cmd = wezterm_cmd . ' ' . vim_cmd
    call system(cmd . ' &')
endfunction
