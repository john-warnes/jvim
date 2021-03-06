"=================================================================
"                           jvim.vim                             "
"=================================================================
" vim:foldmarker={,}:foldmethod=marker:
"=================================================================
"  Revision  678
"  Modified  Saturday, 16 December 2017
"=================================================================

scriptencoding utf-8
setlocal keywordprg=:help
"=================================================================

"noremap <esc>^[ <esc>^[


"=================================================================
" Include Guard
"=================================================================
let g:Jvim#loaded = get(g:, 'Jvim#loaded', 0)
if (g:Jvim#loaded)
    finish
endif
let g:Jvim#loaded=1


"=================================================================
" jvim Setttings {
"=================================================================
let g:Jvim#vimopts#colorColumn        = get(g:, 'Jvim#vimopts#colorColumn',       81) " Set long line guide
let g:Jvim#vimopts#useSystemClipboard = get(g:, 'Jvim#vimopts#useSystemClipboard', 1) " Try to use system clipboard

let g:Jvim#highlightRed = get(g:, 'Jvim#hidden#showTrailing', 'GruvboxRedBold') " Highlight to link for Red

let g:Jvim#hidden#showTrailing = get(g:, 'Jvim#hidden#showTrailing', 1) " Show Tailing Spaces
let g:Jvim#hidden#showEol      = get(g:, 'Jvim#hidden#showEol',    0)   " Show EOL marker
let g:Jvim#hidden#showIndent   = get(g:, 'Jvim#hidden#showIndent', 0)   " Show indent guides when (F2 Toggles)
let g:Jvim#hidden#codePretty   = get(g:, 'Jvim#hidden#codePretty', 1)   " Replace some chars with alternatives (F2 Toggles)

let g:Jvim#presistentUndo#enable = get(g:, 'Jvim#presistentUndo#enable', 1) " Use persistent Undo
let g:Jvim#presistentUndo#dir    = get(g:, 'Jvim#presistentUndo#dir', expand($DOTFILES.'/vim/undo')) " Where to store persistent files

let g:Jvim#folding#syntax = get(g:, 'Jvim#folding#syntax', 1) " Enable folding by syntax for all files
                                                              "  NOTE: Might be slow on older systems
let g:Jvim#folding#fold = get(g:, 'Jvim#folding#fold',     3) " Folding Mode on File Open
                                                              " 0: none default vim
                                                              " 1: open all folds on file open
                                                              " 2: close all folds on file open
                                                              " 3: Auto save folds and reload them
                                                              "  NOTE: <t><t> in normal mode to toggle folds

let g:Jvim#quickFix#enable     = get(g:, 'Jvim#quickFix#enable',    0)  " Enable auto resizing of the quick fix window
let g:Jvim#quickFix#heightMin  = get(g:, 'Jvim#quickFix#heightMin', 3)  " Limit the MIN size of the quick fix window
let g:Jvim#quickFix#heightMax  = get(g:, 'Jvim#quickFix#heightMax', 10) " Limit the MAX size of the quick fix window

let g:Jvim#metadata#enable     = get(g:, 'Jvim#metadata#enable',     1) " enable metadata auto update on file save
let g:Jvim#metadata#maxSearch  = get(g:, 'Jvim#metadata#maxSearch', 50) " Max lines at top of file to search for meta data tags
let g:Jvim#metadata#dateFormat = get(g:, 'Jvim#metadata#dateFormat', '%A, %d %B %Y') " Format for template and metadata dates (man date)

let g:Jvim#comment#enable   = get(g:, 'Jvim#comment#enable', 1) " Allow comment and uncomment system

" Debuging and testing
let g:Jvim#testing#enable   = get(g:, 'Jvim#testing#enable', 0) " enable testing area
let g:Jvim#debug#enable     = get(g:, 'Jvim#debug#enable'  , 0) " enable debug area

let g:Jvim#vimstatus#enable = get(g:, 'g:Jvim#vimstatus#enable', 1) " enable vimstatus status line
"} ===


"=================================================================
" Readme, Help, and Key Map Listing {
"=================================================================
" README: "../README.md"
"
" ### Window Creation/Deletion
" `<Ctrl+w><Del>` or `<C-w><BackSpace>` to close current window
" `<Ctrl+w>|` or `<Ctrl+w>\` Create new file in vertical split window
" `<Ctrl+w>-` or `<Ctrl+=>` Create new file in horizontal split window
" *NOTE* Use the *mouse* for easy control over window splits `[Click]` and `[Drag]` on window the *separator*
"
" ### Window and Tab Movement
" `<C-PageUp>` and `<C-PageDown>` Change current tab
" `<Ctrl+Left>` and `<Ctrl+Right>` Move cursor to *Left/Right Window*, or if at screen edge change to *Next/Prev Tab*
" `<Ctrl+Up>` and `<Ctrl+Down>` Move cursor to *Up/Down Window*
" `<Leader><Arrow Key>` does the same as `<Ctrl+Arrow Key>`
" `<Alt+Left>` Move current tab left
" `<Alt+Right>` Move current tab right
"
" ### Commands
" `:TrimFile` Trim trailing white space(s) from current file
" `:w!!` Force saving current file with *sudo* (protected file)
"
" ### Visual Mode
" `<tab>` Jump to matching braces, parentheses, etc
" `<` or `>` Indent or unindent lines selected lines
" `<S-home>` Visually select from cursor to star of line
" `<S-end>` Visually select from cursor to end of line
"
" ### Normal Mode
"
" #### Code Folding
" `<t><t>` Toggle open/close current fold
" `<z><M>` Close *all* folds
" `<z><R>` Open *all* folds
"
" #### Files
" `<f><t>` open file *under cursor* in *new tab* (or current file)
" `<f><f>` open file *under cursor* in new *vertical split* window (or current file)
"
" #### Search
" `<Leader>/` or `<Ctrl+n>` Clear current search highlight
" `<leader>p` Manually toggle *Paste Mode* use if you have problems pasting into vim from outside programs
"
" #### Movement
" `<tab>` Jump to matching (braces, parentheses, etc)
"
" #### Display
" `<F2>` Show/hide indent guides and CodePretty()
" ![Indent Guide Example](/_assets/Indet_Flip.gif "Indent Guides")
"
" #### Spelling Help
" `==` to autocorrect word under cursor
" `z=` to list possible corrections of word under cursor
" `u`  to undo
"
" #### GUI menu
" `<F4>` Open Terminal version of the GUI menu
" - Use `<Left>`, `<Right>` or `<Tab>` to navigate
" - `<Enter>` to select
" - `<Esc>` to quit
"
" #### Vim Scripting
" `<Shift+F5>` re-source current file (vim files only)
"
" ### Other fixes
"
" #### Command Mode
" `:Q` becomes `q`
" `:Q!` becomes `q!`
" `:W` becomes `w`
" `:W!` becomes `w!`
"
" } ===

set modeline
set modelines=5

" If you're using a symlink to your script, but your resources are in
" the same directory as the actual script, you'll need to do this:
"   1: Get the absolute path of the script
"   2: Resolve all symbolic links
"   3: Get the folder of the resolved absolute filer
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')


"=================================================================
" Vim options
"=================================================================
execute 'source ' . s:path . '/' . 'vimopt.source'


"=================================================================
" Remember file positions
"=================================================================
execute 'source ' . s:path . '/' . 'remeberposistion.source'


"=================================================================
" Hidden characters
"=================================================================
execute 'source ' . s:path . '/' . 'hidden.source'


"=================================================================
" folding
"=================================================================
execute 'source ' . s:path . '/' . 'folding.source'


"=================================================================
" Persistent Undo
"=================================================================
execute 'source ' . s:path . '/' . 'persistentUndo.source'


"=================================================================
" Metadata support
"=================================================================
execute 'source ' . s:path . '/' . 'metadata.source'


"=================================================================
" Key mappings
"=================================================================
execute 'source ' . s:path . '/' . 'keymaps.source'


"=================================================================
" Comment and uncomment
"=================================================================
execute 'source ' . s:path . '/' . 'comment.source'


"=================================================================
" Quick fix window
"=================================================================
execute 'source ' . s:path . '/' . 'quickfix.source'


"=================================================================
" Testing
"=================================================================
execute 'source ' . s:path . '/' . 'testing.source'


"=================================================================
" Builtin status line
"=================================================================
execute 'source ' . s:path . '/' . 'vimstatus.source'


"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" Testing Comment != <= >= x^2 y^3 1^2 pi 44^2 pie
" EOF
