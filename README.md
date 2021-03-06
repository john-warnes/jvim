# JVim Plugin
Version 2.0  

## Installation
Install this plugin as you would any other vim plugin  
Vundle example:
```
Plugin 'john-warnes/jvim'
```
vim-plug example:
```
Plug 'john-warnes/jvim'
```

## Features
- Fixing Quickfix Window Size
- Folding Defaults
- Use detected file sytnax for code folding support
- Automatically return to the last position of previously edited files
- Spell check on by default
- Mouse support for terminal vim
- Use system clipboard for vim
- Show trailing white space
- Show EOL marked (off by default)
- Show many hidden characters: Tabs, NBSP, Extends, Precedes
- Show simple indent guide for <space> indented files
- Persistent Undo (undo saved on a previously edited file)
- Many helpful <Arrow Key> mapping for the new users
    - Same mappings supported with regular vim movement keys
- Many other useful key mapping

## Options
Place options before your `Plug 'john-warnes/jvim'` line in vimrc  
Options shown with defaults  
```
let g:JV_vimDir             = $HOME/.vim         " Setup Vim Directory
let g:JV_showTrailing       = 1                  " Show Tailing Spaces
let g:JV_showEol            = 0                  " Show EOL marker
let g:JV_usePresistent_Undo = 1                  " Use persistent Undo
let g:JV_colorColumn        = 81                 " Set long line guide
let g:JV_red                = 'GruvboxRedBold'   " Highlight link for Red
let g:JV_useSystemClipboard = 1                  " Try to use system clipboard
let g:JV_IndentGuide        = 1                  " Show indent guides when (F2 Toggle)
let g:JV_codePretty         = 1                  " Replace some chars with alternatives (F2 Toggle)
let g:JV_quickFixHeightMin  = 3                  " Limit the MIN size of the quick fix window
let g:JV_quickFixHeightMax  = 10                 " Limit the MAX size of the quick fix window
let g:JV_foldingSyntax      = 1                  " Enable fold=syntax for all files
                                                 " NOTE:Might be slow on older systems
let g:JV_foldingDefault     = 2                  " Folding Mode on File Open
                                                 "   0 no default (might remember last)
                                                 "   1 open all folds on file open
                                                 "   2 close all folds on file open
                                                 "   NOTE: <t><t> normal mode to toggle folds
```

### Window Creation/Deletion
`<Ctrl+w><Del>` or `<C-w><BackSpace>` to close current window  
`<Ctrl+w>|` or `<Ctrl+w>\` Create new file in vertical split window  
`<Ctrl+w>-` or `<Ctrl+=>` Create new file in horizontal split window  
*NOTE* Use the *mouse* for easy control over window splits `[Click]` and `[Drag]` on window the *separator*  

### Window and Tab Movement
`<C-PageUp>` and `<C-PageDown>` Change current tab  
`<Ctrl+Left>` and `<Ctrl+Right>` Move cursor to *Left/Right Window*, or if at screen edge change to *Next/Prev Tab*  
`<Ctrl+Up>` and `<Ctrl+Down>` Move cursor to *Up/Down Window*  
`<Leader><Arrow Key>` does the same as `<Ctrl+Arrow Key>`  
`<Alt+Left>` Move current tab left  
`<Alt+Right>` Move current tab right  

### Commands
`:TrimFile` Trim trailing white space(s) from current file  
`:w!!` Force saving current file with *sudo* (protected file)  

### Visual Mode
`<tab>` Jump to matching braces, parentheses, etc  
`<` or `>` Indent or unindent lines selected lines  
`<S-home>` Visually select from cursor to star of line  
`<S-end>` Visually select from cursor to end of line  

### Normal Mode

#### Code Folding
`<t><t>` Toggle open/close current fold  
`<z><M>` Close *all* folds  
`<z><R>` Open *all* folds  

#### Files
`<f><t>` open file *under cursor* in *new tab* (or current file)  
`<f><f>` open file *under cursor* in new *vertical split* window (or current file)  

#### Search
`<Leader>/` or `<Ctrl+n>` Clear current search highlight  
`<leader>p` Manually toggle *Paste Mode* use if you have problems pasting into vim from outside programs  

#### Movement
`<tab>` Jump to matching (braces, parentheses, etc)  

#### Display
`<F2>` Show/hide indent guides and CodePretty()  

Indent guide example  
![Indent Guide Example](/_assets/Indet_Flip.gif "Indent Guides")

Example of codePretty text changes
![Indent Guide Example](/_assets/codePretty.gif "codePretty")

#### Spelling Help
`==` to autocorrect word under cursor  
`z=` to list possible corrections of word under cursor  
`u`  to undo  

#### GUI menu
`<F4>` Open Terminal version of the GUI menu  
- Use `<Left>`, `<Right>` or `<Tab>` to navigate  
- `<Enter>` to select  
- `<Esc>` to quit  

#### Vim Scripting
`<Shift+F5>` re-source current file (vim files only)  

### Other fixes

#### Command Mode
`:Q` becomes `q`  
`:Q!` becomes `q!`  
`:W` becomes `w`  
`:W!` becomes `w!`  


