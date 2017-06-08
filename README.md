# JVim Plugin

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
### Features

    - Use detected file sytnax for code folding support
    - Automatically return to the last position of previously edited files
    - Spell check on by default
    - Mouse support for terminal vim
    - Use system clipboard for vim
    - Show trailing white space
    - Show EOL marked (off by defualt)
    - Presistent Undo (undo on a previously edited file)
    - Many helpful <Arrow Key> mapping for the new users
        - Same mapping support with regualer vim movment keys
    - Show simple indent guide for <space> indented files
    - Many other useful key mapping

## Options

    Place options before you `Plug` line in vimrc

    Options shown with defualts
    ```
    g:JV_vimDir="$HOME/.vim"                  "Setup Vim dirctory
    g:JV_showTrailing = 1                     "Show Tailing Spaces
    g:JV_showEol = 0                          "Show EOL marker
    g:JV_showIndentGuides = 1                 "Show indents
    g:JV_usePresistentUndo = 1                "Use presistent Undo
    g:JV_colorColumn = join(range(81,83),',') "Set long line guide
    g:JV_red = 'GruvboxRedBold'               "Highlight link for Red
    g:JV_useSystemClipboard = 1               "Use system clipboard
    ```


## Commands


### Window Commands
    Create window vsplit <C-w>|
    Create window hsplit <C-w>-
    To change windows size just click on sperator with mouse amd drag.

### Tabs
    Change Tabs with '<C-PageUp>' and '<C-PageDown>'

### Saving
    ':w!!' Save with sudo (in case you edited protected file and forgot)

### Indent Guide (Spaces for indents)
    'F2' to toggle on or off.

### Spelling Help

    == to autocorrect word under cursor
    z= to list possable corretions of word under cursor
    u  to undo

    Common CMD misspelling correction
    Q = q
    Q! = q!
    W = w
    W! = w1
