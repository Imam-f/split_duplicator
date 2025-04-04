# Split Duplicator

A Vim plugin that provides two main features:
- Duplicate text to a new split window
- Open the current file in WezTerm with auto-reload

## Installation

### Using a plugin manager (recommended)

#### [vim-plug](https://github.com/junegunn/vim-plug)
Plug 'yourusername/split-duplicator'

#### [Vundle](https://github.com/VundleVim/Vundle.vim)
Plugin 'yourusername/split-duplicator'

#### [NeoBundle](https://github.com/Shougo/neobundle.vim)
NeoBundle 'yourusername/split-duplicator'

#### [Pathogen](https://github.com/tpope/vim-pathogen)
git clone https://github.com/yourusername/split-duplicator.git ~/.vim/bundle/split-duplicator

### Manual installation

Copy the contents of each directory into the corresponding directories in your
`~/.vim` or `~/.config/nvim` directory.

## Usage

### Duplicate to Split

Use `<Leader>ds` in normal mode to duplicate the current line and surrounding lines to a new split window. In visual mode, it duplicates the selected text.

The plugin automatically determines whether to create a horizontal or vertical split based on your window dimensions.

### Open in WezTerm

Use `<Leader>wt` to open the current file in a new WezTerm window with auto-reload enabled. The new window will focus on the current line or visual selection.

## Configuration

You can customize the plugin behavior with the following variables:

" Disable default mappings
let g:split_duplicator_no_mappings = 1

" Set custom editor for WezTerm (default is nvim if available, otherwise vim)
let g:split_duplicator_editor = 'nvim'

" Set custom terminal command (default is 'wezterm start --')
let g:split_duplicator_terminal = 'wezterm start --'

### Custom Mappings

If you've disabled the default mappings, you can set your own:

nmap <F5> <Plug>SplitDuplicatorDuplicate
vmap <F5> <Plug>SplitDuplicatorDuplicate
nmap <F6> <Plug>SplitDuplicatorWezTerm
vmap <F6> <Plug>SplitDuplicatorWezTerm

## Commands

The plugin provides the following commands:

- `:DuplicateToSplit [count]` - Duplicate current line +/- [count] lines to a new split
- `:OpenInWezTerm [count]` - Open current file in WezTerm, focusing on current line +/- [count] lines

## Functions

For advanced usage, you can directly call the plugin functions:

call split_duplicator#duplicate_to_split(count)
call split_duplicator#open_in_wezterm(count)

