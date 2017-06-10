"
"          gg                gg
"          ""                ""
"          gg     ggg    gg  gg    ,ggg,,ggg,,ggg,
"          8I    d8"Yb   88bg88   ,8" "8P" "8P" "8,
"         ,8I   dP  I8   8I  88   I8   8I   8I   8I
"       _,d8I ,dP   I8, ,8I_,88,_,dP   8I   8I   Yb,
"     888P"8888"     "Y8P" 8P""Y88P'   8I   8I   `Y8
"--------,d8I'------------------------------------------
"      ,dP'8I
"     ,8"  8I
"     I8   8I
"     `8, ,8I
"      `Y8P"
"
"=================================================================
" Local file settings {
"=================================================================
set encoding=utf-8
scriptencoding utf-8
setlocal foldmarker={,}
setlocal foldmethod=marker
setlocal foldcolumn=1
setlocal keywordprg=:help
" } ===


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
if !exists('g:JV_usePresistent_Undo')
    let g:JV_usePresistent_Undo = 1                  "Use presistent Undo
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
" Check ../README.MD


"=============================================================================
" Performance Options {
"=============================================================================
    set synmaxcol=1000          " Only syntax highlight 1000 columns right
    set undolevels=2500         " How many undo to remember
    set undoreload=5000         " How many lines to save for undo
    set history=5000            " How many user command remember in history

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

    " Cycle Vim Folds
    nnoremap tt za

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
"if exists(g:CodePretty)
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
" Indent Guides for spaces {
"=============================================================================

if !exists('g:no_vim_conceal') && has('conceal') && exists('g:JV_IndentGuide')

    function! ShowIndents()
            let b:IndentSize = &shiftwidth == 0 ? &tabstop : &shiftwidth
            execute 'syntax match Indent /^ \+/ containedin=ALL contains=IndentLevel'
            execute 'syntax match IndentLevel /\v(^( {'.(-b:IndentSize).'})+)@<= ( {0,'.(b:IndentSize-1).'})@=/ conceal cchar=¦ containedin=Indent contains=none'

            highlight clear Conceal
            highlight link Conceal GruvboxGray
    endfunction

    set conceallevel=2
    nnoremap <silent> <F2> :let &conceallevel = ( &conceallevel == 2 ? 0 : 2 )<CR>

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
if exists('g:JV_usePresistent_Undo') && has('persistent_undo')
    let &undodir= expand($DOTFILES.'/vim/undo')
    silent! call mkdir(&undodir)                " Create dir if needed
    set undofile                                " Use a undofile
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
