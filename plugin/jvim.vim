"                        _       _                                "
"                       (_)_   _(_)_ __ ___                       "
"                       | \ \ / / | '_ ` _ \                      "
"                       | |\ V /| | | | | | |                     "
"                      _/ | \_/ |_|_| |_| |_|                     "
"                     |__/                                        "
"
"=================================================================
" TOP Local file settings {
"=================================================================
set encoding=utf-8
scriptencoding utf-8
" } ===


"=============================================================================
" JVim Settings {
"=============================================================================
if !exists('g:JV_vimDir')
    "let g:JV_vimDir="$HOME/.vim"                    "Setup Vim directory
    let g:JV_vimDIR= expand($HOME.'/vim')
endif
if !exists('g:JV_showTrailing')
    let g:JV_showTrailing = 1                       "Show Tailing Spaces
endif
if !exists('g:JV_showEol')
    let g:JV_showEol = 0                            "Show EOL marker
endif
if !exists('g:JV_usePresistent_Undo')
    let g:JV_usePresistent_Undo = 1                 "Use persistent Undo
endif
if !exists('g:JV_colorColumn')
    let g:JV_colorColumn = join(range(81,83),',')   "Set long line guide
    "let g:JV_colorColumn = 8
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
if !exists('g:JV_codePretty')
    let g:JV_codePretty = 0                         "Replace some chars with alternatives
    "using spaces F2 to toggle
endif

" } ===


"=============================================================================
" Help and notes {
"=============================================================================
" Check ../README.MD


"=============================================================================
" Performance Options {
"=============================================================================
set synmaxcol=200           " Only syntax highlight 200 columns right
set undolevels=5000         " How many undo to remember
set undoreload=5000         " How many lines to save for undo
set history=8000            " How many user command remember in history

" } ===


"=============================================================================
" Vim Options {
"=============================================================================
set mouse=a         " Use mouse to place cursor
set noshowmode      " Don't print mode in status line (Plugin does this already)
set autoread        " Auto read changes in file from disk
set gdefault        " Automatically assume global in replacements :%s/old/new/
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
" Color Column Support {
"=============================================================================
if exists('g:JV_colorColumn')
    let &colorcolumn=g:JV_colorColumn
endif
" } ===


"=============================================================================
" Fix Quickfix Window Height {
"=============================================================================
" :cw to open window
function! AdjustWindowHeight(minheight, maxheight)
    let l:l = 1
    let l:n_lines = 0
    let l:w_width = winwidth(0)
    while l:l <= line('$')
        " number to float for division
        let l:l_len = strlen(getline(l:l)) + 0.0
        let l:line_width = l:l_len/l:w_width
        let l:n_lines += float2nr(ceil(l:line_width))
        let l:l += 1
    endwhile
    exe max([min([l:n_lines, a:maxheight]), a:minheight]) . 'wincmd _'
endfunction

augroup QuickFixWin
    au FileType qf call AdjustWindowHeight(3, 10)
augroup end
" } ===


"=============================================================================
" Vim Folding {
"=============================================================================
set foldminlines=3
set foldmethod=syntax
setlocal foldmarker={,}
setlocal foldmethod=marker
setlocal foldcolumn=1
setlocal keywordprg=:help

" Cycle Vim Folds

nnoremap tt za
nnoremap <Tab><Tab> za

function! OpenAllFolds()
    if (&l:modifiable)
        normal! zR
    endif
endfunction

function! OpenCursorFold()
    if (&l:modifiable)
        normal! zv
    endif  "open only fold with cursor
endfunction

" On file open, open any folds the cursor is in
augroup OpenCursorLine
    autocmd!
    autocmd BufWinEnter * call OpenAllFolds() "open all folds
    autocmd BufWinEnter * call OpenCursorFold() "open only fold with cursor
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
endif

" } ===

"=============================================================================
" Show some characters as pretty {
"=================================================================
if exists(g:JV_codePretty) && has('conceal') && (&encoding ==? 'utf-8')
    " Testing Comment != <= >= x^2 y^3 1^2 pi 44^2 pie
    function! CodePretty()
        " Swap some characters as prettier ones
        execute 'syntax match Operator "<=" conceal cchar=≤ contained containedin=ALL'
        execute 'syntax match Operator ">=" conceal cchar=≥ contained containedin=ALL'
        execute 'syntax match Operator "!=" conceal cchar=≠ contained containedin=ALL'
        execute 'syntax match Operator /\s\@<=pi\s\@=/ conceal cchar=π contained containedin=ALL'
        execute 'syntax match Operator /\w\@<=\^2/ conceal cchar=² contained containedin=ALL'
        execute 'syntax match Operator /\w\@<=\^3/ conceal cchar=³ contained containedin=ALL'
    endfunction

    augroup codePretty
        autocmd!
        autocmd BufReadPost,BufNewFile * call CodePretty
    augroup end
endif
" } ===


"=============================================================================
" Indent Guides for spaces {
"=============================================================================

if !exists('g:no_vim_conceal') && has('conceal') && exists('g:JV_IndentGuide')

    function! ShowIndents()
        let b:IndentSize = &shiftwidth == 0 ? &tabstop : &shiftwidth
        execute 'syntax match Indent /^ \+/ containedin=ALL contains=IndentLevel'
        execute 'syntax match IndentLevel /\v(^( {'.(-b:IndentSize).'})+)@<= ( {0,'.(b:IndentSize-1).'})@=/ conceal cchar=¦ containedin=Indent contains=none'
    endfunction

    set conceallevel=2
    nnoremap <silent> <F2> :let &conceallevel = ( &conceallevel == 2 ? 0 : 2 )<CR>

    augroup indentGuide
        autocmd!
        autocmd BufReadPost,BufNewFile * call ShowIndents()
"        autocmd ColorScheme gruvbox
"                    \ highlight clear Conceal |
"                    \ highlight link Conceal GruvboxGray
    augroup end
endif

" } ===


"=============================================================================
" Persistent_Undo {
"=============================================================================
if exists('g:JV_usePresistent_Undo') && has('persistent_undo')
    let &undodir= expand($DOTFILES.'/vim/undo')
    silent! call mkdir(&undodir)                " Create directory if needed
    set undofile                                " Use a undo file
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
nnoremap <C-w><Del> :close<CR>
nnoremap <C-w><BS> :close<CR>
nnoremap <silent> <C-w><Bar> :set splitright<CR>:vnew<CR>:set nosplitright<CR>
nnoremap <silent> <C-w>\ :set splitright<CR>:vnew<CR>:set nosplitright<CR>
nnoremap <silent> <C-w>- :set splitbelow<CR>:new<CR>:set nosplitbelow<CR>

"} ===

" Mapping for Tabs Control ========== {
"
"  <C-PageUp>    Built in next tab
"  <C-PageDown>  Built in prev tab
"  <ft> open file in new tab
"  <ff> open file in new v split window
nnoremap ft <C-w>gf
nnoremap <silent> ff :set splitright<CR><C-w>vgf<CR>:set nosplitright<CR>

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

nnoremap <Leader><Right> <C-w>l
nnoremap <Leader><Left> <C-w>h
nnoremap <Leader><Up> <C-w>k
nnoremap <Leader><Down> <C-w>j
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
    else
        set clipboard=unnamedplus
    endif
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
