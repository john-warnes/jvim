"=========================================================================om
"#               __ _   _ _ _ __ ___  _ __ ___    __     ___                 #
"#              |_ \ \ / / | '_ ` _ \| '__/ __|  /  |   | _ |                #
"#             ___| \ V /| | | | | | | | | (___   | | _ ||_||                #
"#             \____|\_/ |_|_| |_| |_|_|  \___|   |_||_||___|                #
"#                                                                           #
"=============================================================================
set encoding=utf-8
scriptencoding utf-8
"if exists('g:JVimLoaded')
"    finish
"endif
"let g:JVimLoaded=1

"=============================================================================
" JVim Settings {
"=============================================================================
if !exists('g:JV_vimDir')
    let g:JV_vimDir="$HOME/.vim"                    "Setup Vim dirctory
endif
if !exists('g:JV_showTrailing')
    let g:JV_showTrailing = 1                       "Show Tailing Spaces
endif
if !exists('g:JV_showEol')
    let g:JV_showEol = 0                            "Show EOL marker
endif
if !exists('g:JV_showIndentGuides')
    let g:JV_showIndentGuides = 1                   "Show indents
endif
if !exists('g:JV_usePresistentUndo')
    let g:JV_usePresistentUndo = 1                  "Use presistent Undo
endif
if !exists('g:JV_colorcolumn')
    let g:JV_colorColumn = join(range(81,83),',')   "Set long line guide
endif
if !exists('g:JV_red')
    let g:JV_red = 'GruvboxRedBold'                 "Highlight link for Red
endif
if !exists('g:JV_useSystemClipboard')
    let g:JV_useSystemClipboard = 1                 "Try to use system clipboard
                                                    "for all of Vim
endif

if !exists('g:JV_IndentGuide')
    let g:JV_IndentGuide = 1                        "Show indent guides when
                                                    "using spaces F2 to toggle
endif


" } ===


"=============================================================================
" Help and notes {
"=============================================================================

" === Commands ===
" :TrimFile " Remove all trailing writespace in file
"
" } ===


"=============================================================================
" Performance Options {
"=============================================================================
    set synmaxcol=1000          " Only syntax highlight 1000 columns right
    set undolevels=1000         " How many undo to remember
    set undoreload=5000         " How many lines to save for undo
    set history=1000            " How many user command remember in hitorty

" } ===


"=============================================================================
" Vim Options {
"=============================================================================
    set mouse=a
    set noshowmode
" } ===


"=============================================================================
" Vim Spell {
"=============================================================================
    set spell
    nnoremap == 1z=
" } ===


"=============================================================================
" Tmux Support {
"=============================================================================
    if exists('$TMUX')
        set ttymouse=xterm2
        set mouse=a
    endif
" } ===


"=============================================================================
" Vim Folding {
"=============================================================================
    set foldminlines=3
    set foldmethod=syntax

    setlocal foldmarker={,}
    setlocal foldmethod=marker
    setlocal foldcolumn=1

    " Cycle Vim Folds
    nnoremap <tab><tab> za

    " On file open, open any folds the cursor is in
    augroup OpenCursorLine
        autocmd!
        autocmd BufWinEnter * normal! zv
    augroup end
" } ===


"=============================================================================
" Show hidden white space {
"=============================================================================
set list    " Enable display of hidden characters

" Show some hidden characters as visible symbols
set listchars=tab:\»\ ,nbsp:␣,extends:»,precedes:«

" Show EOL?
if (g:JV_showEol && &list)
    set listchars+=eol:↲
endif

" Show trailing spaces?
if (g:JV_showTrailing && &list)

    set listchars+=trail:·
    highlight clear SpecialKey
    execute 'highlight link SpecialKey' g:JV_red

    augroup JV_trailingSpaceColorFix
        autocmd!
        autocmd ColorScheme *
                    \ highlight clear SpecialKey |
                    \ execute "highlight link SpecialKey" g:JV_red
    augroup end
else
    augroup TrailingSpace
        autocmd!
    augroup end
endif
" } ===


"=============================================================================
" Show some characters as pretty {
"=================================================================
"if exists(s:CodePretty)
"    if !exists('g:no_vim_conceal') && has('conceal') && &enc=='utf-8'
"
"        " Testing Comment != <= >= x^2 y^3 1^2 pi 44^2 pie
"        function! CodePretty()
"            " Swap some charcters as prettier ones
"            execute 'syntax match Operator "<=" conceal cchar=≤ contained containedin='.s:container
"            execute 'syntax match Operator ">=" conceal cchar=≥ contained containedin='.s:container
"            execute 'syntax match Operator "!=" conceal cchar=≠ contained containedin='.s:container
"            execute 'syntax match Operator /\s\@<=pi\s\@=/ conceal cchar=π contained containedin='.s:container
"            execute 'syntax match Operator /\w\@<=\^2/ conceal cchar=² contained containedin='.s:container
"            execute 'syntax match Operator /\w\@<=\^3/ conceal cchar=³ contained containedin='.s:container
"        endfunction
"
"    endif
"endif
" } ===


"=============================================================================
" Spaces Indent Guide {
"=============================================================================

if !exists('g:no_vim_conceal') && has('conceal') && exists('g:JV_IndentGuide')

    let g:IndentSize = &l:shiftwidth == 0 ? &l:tabstop : &l:shiftwidth

    function! ShowIndents()
            execute 'syntax match Indent /\v^\s+/ containedin=ALL contains=IndentLevel'
            execute 'syntax match IndentLevel /\v^@<=\s(\s{'.(g:IndentSize-1).'})@=/ conceal cchar=¦ contained containedin=Indent'
            execute 'syntax match IndentLevel /\v(^(\s{'.(g:IndentSize).'})+)@<=\s(\s{'.(g:IndentSize-1).'})@=/ conceal cchar=¦ contained containedin=Indent'

            highlight clear Conceal |
            highlight link Conceal GruvboxGray
    endfunction

    set conceallevel=1
    nnoremap <silent> <F2> :let &conceallevel = ( &conceallevel == 1 ? 0 : 1 )<CR>

    augroup codePretty
        autocmd!
        autocmd BufReadPost,BufNewFile * call ShowIndents()
        autocmd ColorScheme gruvbox
                    \ highlight clear Conceal |
                    \ highlight link Conceal GruvboxGray
    augroup end
endif

" } ===


"=============================================================================
" Persistent_Undo {
"=============================================================================
if exists('s:UsePresistent_Undo') && has('persistent_undo') && exists('*mkdir')
    let &undodir= expand(g:vimDir.'/undo')
    silent! call mkdir(&undodir)      " Create dir if needed
    set undofile                " Use a undofile
endif
" } ===


"=============================================================================
" Small Useful Support Functions {
"=============================================================================
command! TrimFile silent! %s/\s\+$//g | echom 'Trailing Space(s) Trimmed'

" sudo write current file
cnoremap w!! w !sudo tee % >/dev/null
" } ==


"=============================================================================
" Useful Mappings and Standard Keys (Arrows etc)  {
"=============================================================================

" Mappings for Window/Buffer Control ========== {
    "set splitright
    "set splitbelow
    nnoremap <C-w><Del> :close<CR>
    nnoremap <C-w><BS> :close<CR>
    nnoremap <C-w><Bar> :set splitright<CR>:vnew<CR>:set nosplitright<CR>
    nnoremap <C-w>- :set splitbelow<CR>:new<CR>:set nosplitbelow<CR>

"} ===

" Mapping for Tabs Control ========== {
"
"  <C-PageUp>    Built in next tab
"  <C-PageDown>  Built in prev tab
    nnoremap <f><f> <C-w>gf
"} ===

" Mappings for Arrow Keys ========== {

" Insert mode
    inoremap <C-Right> <Esc><C-w>li
    inoremap <C-Left> <Esc><C-w>hi
    inoremap <C-Up> <Esc><C-w>ki
    inoremap <C-Down> <Esc><C-w>ji

" Normal mode
    nnoremap <C-Right> <C-w>l
    nnoremap <C-Left> <C-w>h
    nnoremap <C-Up> <C-w>k
    nnoremap <C-Down> <C-w>j
" } ===

    " Easier moving of code block indents Try to go into
    " visual mode (v), then select several lines of code here and
    " then press ``>`` several times.
    vnoremap < <gv
    vnoremap > >gv

    " Clear Current Search Highlight
    nnoremap <silent> <leader>/ :nohlsearch<CR>
    nnoremap <silent> <C-n> :nohlsearch<CR>

" Spelling and Better Living ========== {
    cnoremap W w
    cnoremap W! w!
    cnoremap Q q
    cnoremap Q! q!
"} ===
"
"} === end Mappings


"=============================================================================
" Try to use System Clipboard {
"=============================================================================
if has('clipboard') && exists('g:JV_useSystemClipboard')
    if has('mac')
        set clipboard=unnamed
    endif
     set clipboard=unnamedplus
endif
" } ===


"=============================================================================
" Return to the last position in the file {
"=============================================================================
augroup return_file_postion
    autocmd!
    au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$")
                \ | exe "normal g'\"" | endif
augroup END
" } ===


"=============================================================================
" Plugin Help Commands {
"=============================================================================
    noremap <S-F5> :source %<CR>
" } ===


"=============================================================================
" Testing Area for new stuff {
"=============================================================================
" Allow the menu in Term mode
if !has('gui_running')
    source $VIMRUNTIME/menu.vim
    set wildmenu
    set cpoptions-=<
    set wildcharm=<C-Z>
    map <F4> :emenu <C-Z>
endif
" } ===

"EOF
