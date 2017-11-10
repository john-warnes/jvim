"                            jvim.vim                            "
"=================================================================
set encoding=utf-8
scriptencoding utf-8
setlocal foldmarker={,}
setlocal foldmethod=marker
setlocal foldcolumn=1
setlocal keywordprg=:help
"=================================================================


"=================================================================
" JVim Settings {
"=================================================================
let g:JV_vimDir             = get(g:, 'JV_vimDir', expand($HOME.'/.vim')) " Setup Vim directory
let g:JV_showTrailing       = get(g:, 'JV_showTrailing', 1)               " Show Tailing Spaces
let g:JV_showEol            = get(g:, 'JV_showEol', 0)                    " Show EOL marker
let g:JV_usePresistent_Undo = get(g:, 'JV_usePresistent_Undo', 1)         " Use persistent Undo
let g:JV_colorColumn        = get(g:, 'JV_colorColumn', 81)               " Set long line guide
                                                                          " let g:JV_colorColumn      = get(g:, 'JV_colorColumn', join(range(81,83),','))
let g:JV_red                = 'GruvboxRedBold'                            " Highlight link for Red
let g:JV_useSystemClipboard = get(g:, 'JV_useSystemClipboard', 1)         " Try to use system clipboard
let g:JV_IndentGuide        = get(g:, 'JV_IndentGuide', 0)                " Show indent guides when (F2 Toggle)
let g:JV_codePretty         = get(g:, 'JV_codePretty', 1)                 " Replace some chars with alternatives (F2 Toggle)

let g:JV_quickFixHeightMin  = get(g:, 'JV_quickFixHeightMin', 3)          " Limit the MIN size of the quick fix window
let g:JV_quickFixHeightMax  = get(g:, 'JV_quickFixHeightMax', 10)         " Limit the MAX size of the quick fix window

let g:JV_foldingSyntax      = get(g:, 'JV_foldingSyntax', 1)              " 1 = enable folding=syntax for all files
    "NOTE:Might be slow on older systems

let g:JV_foldingDefault     = get(g:, 'JV_foldingDefault', 3)             " Folding Mode on File Open
                                                                          " 0: none default vim
                                                                          " 1: open all folds on file open
                                                                          " 2: close all folds on file open
                                                                          " 3: Auto save folds and reload them
                                                                          " NOTE: ''tt'' in normal mode to toggle folds
" } ===


"=================================================================
" Readme, Help, and Key Map Listing
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

"=================================================================
" Performance Options {
"=================================================================
set synmaxcol=500           " Only syntax highlight 500 columns right
set undolevels=2000         " How many undo to remember
set undoreload=10000        " How many lines to save for undo
set history=2000            " How many user command remember in history
" } ===


"=================================================================
" Vim Options {
"=================================================================
"set noshowmode      " Don't print mode in status line (Plugin does this already)
set autoread        " Auto read changes in file from disk
set gdefault        " Automatically assume global in replacements :%s/old/new/
set mousehide       " Hide mouse pointer when typing
" } ===


"=================================================================
" Vim Spell {
"=================================================================
 " Use ''=='' to have vim guess the first spelling
 " Use ''z='' to have vim show a list of possible spellings
set spell
nnoremap == 1z=
" } ===


"=================================================================
" Color Column Support {
"=================================================================
let &colorcolumn=g:JV_colorColumn
" } ===


"=================================================================
" Fix Quickfix Window Height {
"=================================================================
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
    au FileType qf call AdjustWindowHeight(g:JV_quickFixHeightMin, g:JV_quickFixHeightMax)
augroup end
" } ===


"=================================================================
" Vim Folding {
"=================================================================
" NOTE foldmethod=syntax can be VERY slow

if (g:JV_foldingSyntax)
    set foldminlines=3
    set foldmethod=syntax
endif

setlocal foldmarker={,}
setlocal foldmethod=marker
setlocal foldcolumn=2


if (g:JV_foldingDefault == 3)
    set foldlevelstart=20
endif

" Cycle Vim Fold
nnoremap tt za

" Open all Folds on file open
function! OpenAllFolds()
    if (&l:modifiable)
        normal! zR
    endif
endfunction

" Close all Folds on file open
function! CloseAllFolds()
    if (&l:modifiable)
        normal! zM
    endif
endfunction

" Open any folds the cursor is in
function! OpenCursorFold()
    if (&l:modifiable)
        normal! zv
    endif  "open only fold with cursor
endfunction

" On file open, open all folds and the fold the cursor is on
augroup OpenCursorLine
    autocmd!
    if (g:JV_foldingDefault == 3)
        autocmd BufWinLeave * mkview
        autocmd BufWinEnter * silent! loadview
        "saved to viewdir
        " you can choose location with
        " autocmd BufWinLeave * execute "mkview! " . expand('<afile>:p:h') . "/." . expand('<afile>:t') . ".view"
        " autocmd BufWinEnter * execute "silent! source " . expand('%:p:h') . "/." . expand('%:t') . ".view"
    endif
    if (g:JV_foldingDefault == 1)
        autocmd BufWinEnter * call OpenAllFolds()   " open all folds
    endif
    if (g:JV_foldingDefault == 2)
        autocmd BufWinEnter * call CloseAllFolds()  " close all folds
    endif
    autocmd BufWinEnter * call OpenCursorFold() " open only fold with cursor
augroup end
" } ===


"=================================================================
" Show hidden white space {
"=================================================================
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


"=================================================================
" Show some characters as pretty {
"=================================================================
if (g:JV_codePretty) && has('conceal')
    " Testing Comment != <= >= x^2 y^3 1^2 pi 44^2 pie
    function! CodePretty()
        if !(&fileencoding ==? 'utf-8')
            return
        endif
        " Swap some characters as prettier ones
        execute 'syntax match Operator "<=" conceal cchar=≤ contained containedin=ALL'
        execute 'syntax match Operator ">=" conceal cchar=≥ contained containedin=ALL'
        execute 'syntax match Operator "!=" conceal cchar=≠ contained containedin=ALL'
        execute 'syntax match Operator /\s\@<=pi\s\@=/ conceal cchar=π contained containedin=ALL'
        execute 'syntax match Operator /\w\@<=\^2/ conceal cchar=² contained containedin=ALL'
        execute 'syntax match Operator /\w\@<=\^3/ conceal cchar=³ contained containedin=ALL'
        execute 'syntax match Operator /\w\@<=\^3/ conceal cchar=³ contained containedin=ALL'
    endfunction

    augroup codePretty
        autocmd!
        autocmd BufReadPost,BufNewFile * call CodePretty()
    augroup end
endif
" } ===


"=================================================================
" Indent Guides for spaces {{
"=================================================================
if !exists('g:no_vim_conceal') && has('conceal') && (g:JV_IndentGuide)

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


"=================================================================
" Persistent_Undo {
"=================================================================
if (g:JV_usePresistent_Undo) && has('persistent_undo')
    let g:undodir=expand($DOTFILES.'/vim/undo')
    silent! call mkdir(g:undodir)  " Create directory if needed
    let &undodir=g:undodir         " Tell vim to use directory
    set undofile                   " Tell vim to use a undo file
else
    set noundofile                 " Do not set undo files
endif
" } ===


"=================================================================
" Small Useful Support Functions {
"=================================================================
command! TrimFile silent! %s/\s\+$//g | echom 'Trailing Space(s) Trimmed'

" sudo write current file
cnoremap w!! w !sudo tee % >/dev/null
" } ==


"=================================================================
" Useful Mappings and Standard Keys (Arrows etc)  {
"=================================================================

" Mappings for Window/Buffer Control ========== {
nnoremap <C-w><Del> :close<CR>
nnoremap <C-w><BS> :close<CR>
nnoremap <silent> <C-w><Bar> :set splitright<CR>:vnew<CR>:set nosplitright<CR>
nnoremap <silent> <C-w>\ :set splitright<CR>:vnew<CR>:set nosplitright<CR>
nnoremap <silent> <C-w>- :set splitbelow<CR>:new<CR>:set nosplitbelow<CR>
nnoremap <silent> <C-w>= :set splitbelow<CR>:new<CR>:set nosplitbelow<CR>
"} ===

" Mapping opening files under cursor ========== {
"  <C-PageUp>    Built in next tab
"  <C-PageDown>  Built in prev tab
"  <ft> open file in new tab
"  <ff> open file in new v split window
nnoremap ft <C-w>gf
nnoremap <silent> ff :set splitright<CR><C-w>vgf<CR>:set nosplitright<CR>
"} ===

" Mappings for Arrow Keys ========== {

" Warp mapping for insert mode
set whichwrap+=<,>,h,l,[,]

" Right Key (Changes window first than try tabs)
function! WinTabNext()
    let g:JV_temp = winnr()
    wincmd l
    if (g:JV_temp == winnr())
        tabnext
    endif
endfunction

" Left Key (Changes window first than try tabs)
function! WinTabPrev()
    let g:JV_temp = winnr()
    wincmd h
    if (g:JV_temp == winnr())
        tabprev
    endif
endfunction

if !exists('$TMUX')
    nnoremap <silent> <C-Left> :call WinTabPrev()<CR>
    nnoremap <silent> <C-Right> :call WinTabNext()<CR>
    nnoremap <silent> <Leader><Left> :call WinTabPrev()<CR>
    nnoremap <silent> <Leader><Right> :call WinTabNext()<CR>

    nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
    nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
else
    nnoremap <C-Right> <C-w>l
    nnoremap <C-Left> <C-w>h
    nnoremap <Leader><Right> <C-w>l
    nnoremap <Leader><Left> <C-w>h
endif

" Ctrl Up/Down Only changes windows
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j
nnoremap <Leader><Up> <C-w>k
nnoremap <Leader><Down> <C-w>j
" } ===

" Easier moving of code block indents ========== {
" Go into visual mode (v), then select several lines of code
" " then press ``>`` several times.
vnoremap < <gv
vnoremap > >gv
" } ===

" Clear current search highlight ========= {
" Use ''<Leader>/'' or ''Ctrl+n''
nnoremap <silent> <leader>/ :nohlsearch<CR>
nnoremap <silent> <C-n> :nohlsearch<CR>
" } ===

" Better Saving and Quiting ========== {
cnoremap W w
cnoremap W! w!
cnoremap Q q
cnoremap Q! q!
cnoremap Wall wall
cnoremap Wall! wall!
" } ===

" Paste Mode Toggle ========== {
" Use ''<leader>p''
set pastetoggle=<leader>p
"} ===

" Normal/Visual <tab> for jumping bracket pairs ========== {
nmap <tab> %
vmap <tab> %
" } ===

" Select Visual ======= {
inoremap <S-home> <ESC>v^
inoremap <S-home> <ESC>v^
nnoremap <S-end> <ESC>v$<Left>
nnoremap <S-end> <ESC>v$<Left>
" } ===

" } === end Mappings


"=================================================================
" Try to use System Clipboard {
"=================================================================
if has('clipboard') && (g:JV_useSystemClipboard)
    if has('mac')
        set clipboard=unnamed
    else
        set clipboard=unnamedplus
    endif
endif
" } ===


"=================================================================
" Return to the last position in the file {
"=================================================================
augroup return_file_postion
    autocmd!
    au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$")
                \ | exe "normal g'\"" | endif
augroup end
" } ===


"=================================================================
" Plugin Help Commands {
"=================================================================
" Use ''Shift+F5'' to resource current files
noremap <S-F5> :source %<CR>
" } ===


"=================================================================
" Testing Area for new stuff {
"=================================================================
" Allow the menu in Term mode
if !has('gui_running')
    source $VIMRUNTIME/menu.vim
    set wildmenu
    set cpoptions-=<
    set wildcharm=<C-Z>
    map <F4> :emenu <C-Z>
endif


" Use Tabs in makefiles php and go
augroup useTabs
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd Filetype php setlocal noexpandtab
    autocmd Filetype go setlocal noexpandtab
augroup end


" Close vim if NERDTree is the last thing standing
augroup closeNerdTree
    autocmd!
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup end

" } ===



"TOTALLY PLUG FREE STATUS LINE {

"" Statusline (requires Powerline font)
"set statusline=
"set statusline+=%(%{'help'!=&filetype?bufnr('%'):''}\ \ %)
"set statusline+=%< " Where to truncate line
"set statusline+=%f " Path to the file in the buffer, as typed or relative to current directory
"set statusline+=%{&modified?'\ +':''}
"set statusline+=%{&readonly?'\ ':''}
"set statusline+=%= " Separation point between left and right aligned items
"set statusline+=\ %{''!=#&filetype?&filetype:'none'}
"set statusline+=%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'')
"  \.('unix'!=#&fileformat?'\ '.&fileformat:'')}%)
"set statusline+=%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)
"set statusline+=\ 
"set statusline+=\ %2v " Virtual column number
"set statusline+=\ %3p%% " Percentage through file in lines as in |CTRL-G|
"
"" ------------------------ 8< ------------------------
"
"" Statusline (requires Powerline font, with highlight groups using Solarized theme)
"set statusline=
"set statusline+=%(%{'help'!=&filetype?bufnr('%'):''}\ \ %)
"set statusline+=%< " Where to truncate line
"set statusline+=%f " Path to the file in the buffer, as typed or relative to current directory
"set statusline+=%{&modified?'\ +':''}
"set statusline+=%{&readonly?'\ ':''}
"set statusline+=\ %1*
"set statusline+=%= " Separation point between left and right aligned items.
"set statusline+=\ %{''!=#&filetype?&filetype:'none'}
"set statusline+=%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'')
"  \.('unix'!=#&fileformat?'\ '.&fileformat:'')}%)
"set statusline+=%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)
"set statusline+=\ %*
"set statusline+=\ %2v " Virtual column number.
"set statusline+=\ %3p%% " Percentage through file in lines as in |CTRL-G|
"
"" Logic for customizing the User1 highlight group is the following
"" - fg = StatusLine fg (if StatusLine colors are reverse)
"" - bg = StatusLineNC bg (if StatusLineNC colors are reverse)
"hi StatusLine term=reverse cterm=reverse gui=reverse ctermfg=14 ctermbg=8 guifg=#93a1a1 guibg=#002b36
"hi StatusLineNC term=reverse cterm=reverse gui=reverse ctermfg=11 ctermbg=0 guifg=#657b83 guibg=#073642
"hi User1 ctermfg=14 ctermbg=0 guifg=#93a1a1 guibg=#073642
"
" https://gist.github.com/ericbn/f2956cd9ec7d6bff8940c2087247b132i
"
" } ====


"EOF
