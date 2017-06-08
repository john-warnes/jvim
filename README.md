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

## Options

    Place options before you `Plug` line in vimrc

    Options shown with defualts
    ```
    g:JV_vimDir="$HOME/.vim"                        "Setup Vim dirctory
    g:JV_showTrailing = 1                           "Show Tailing Spaces
    g:JV_showEol = 0                                "Show EOL marker
    g:JV_showIndentGuides = 1                       "Show indents
    g:JV_usePresistentUndo = 1                      "Use presistent Undo
    g:JV_colorColumn = join(range(81,83),',')       "Set long line guide
    g:JV_red = 'GruvboxRedBold'                     "Highlight link for Red
    g:JV_useSystemClipboard = 1                     "Try to use system clipboard
                                                "for all of Vim
    ```

### Notes

    - foldmethod = sytnax
    - automaticly return to the last position of prevosly edited files
    - vim Spell on by default

### Clipboard

    if 

## Commands


### Window Commands
    Create window vsplit <C-w>|
    Create window hsplit <C-w>-
    To change windows size just click on sperator with mouse amd drag.

### Tabs
    Change tabs <C-PageUp> / <C-PageDown>

### Saving

    :w!! Save with sudo (in case you edited protected file and forgot)



### Indent Guide (Spaces for indents)
    Uses vim conceal mode to create Indent Guides for space based indents
    F2 to toggle on or off.


### Spelling Help

    == to autocorrect word under cursor
    z= to list possable corretions of word under cursor
    u  to undo

    Common CMD misspelling correction
    Q = q
    Q! = q!
    W = w
    W! = w1
