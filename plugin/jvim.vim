"=============================================================================
"#               __ _   _ _ _ __ ___  _ __ ___    __     ___                 #
"#              |_ \ \ / / | '_ ` _ \| '__/ __|  /  |   | _ |                #
"#             ___| \ V /| | | | | | | | | (___   | | _ ||_||                #
"#             \____|\_/ |_|_| |_| |_|_|  \___|   |_||_||___|                #
"#                                                                           #
"=============================================================================

if exists('g:JVimLoaded')
    finish
endif

let g:JVimLoaded=1

"
"=============================================================================
" SETTINGS {
"=============================================================================
if !exists('g:JV_vimDir')
    let g:JV_vimDir="$HOME/.vim"                    "Setup Vim dirctory
endif

if !exists('g:JV_showTrailing')
    let g:JV_showTrailing=1                             "Show Tailing Spaces
endif

if !exists('g:JV_showEol')
    let g:JV_showEol=1                                  "Show EOL marker
endif

if !exists('g:JV_showIndentGuides')
    let g:JV_showIndentGuides=1                         "Show indents
endif

if !exists('g:JV_usePresistentUndo')
    let g:JV_usePresistentUndo=1                        "Use presistent Undo
endif

if !exists('g:JV_colorcolumn')
    let g:JV_colorColumn=join(range(81,83),',')         "Set long line guide
endif

if !exists('g:JV_colors')
    let g:JV_colors=1
    let g:JV_red='GruvboxRedBold'
endif
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
    execute "highlight link SpecialKey" g:JV_red

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



"=================================================================    
" Show some characters as prettier, Indent guides
"=================================================================
"if (s:CodePretty)
"    if !exists('g:no_vim_conceal') && has('conceal') && &enc=='utf-8'
"
"        " Testing Comment != <= >= x^2 y^3 1^2 pi 44^2 pie
"        function! CodePrettyColors()
"            highlight clear Conceal
"            highlight link Conceal GruvboxGray
"        endfunction
"
"        function! CodePretty()
"            call CodePrettyColors()
"            let Spaces = &l:shiftwidth == 0 ? &l:tabstop : &l:shiftwidth
"
"            " Swap some charcters as prettier ones
"            execute 'syntax match Operator "<=" conceal cchar=≤ contained containedin='.s:container
"            execute 'syntax match Operator ">=" conceal cchar=≥ contained containedin='.s:container
"            execute 'syntax match Operator "!=" conceal cchar=≠ contained containedin='.s:container
"            execute 'syntax match Operator /\s\@<=pi\s\@=/ conceal cchar=π contained containedin='.s:container
"            execute 'syntax match Operator /\w\@<=\^2/ conceal cchar=² contained containedin='.s:container
"            execute 'syntax match Operator /\w\@<=\^3/ conceal cchar=³ contained containedin='.s:container
"
"            " Indent Guides
"            if (s:CodePrettyShowIndent)
"                execute 'syntax match Indent /\v^\s+/ containedin=ALL contains=IndentLevel'
"                execute 'syntax match IndentLevel /\v^@<=\s(\s{'.(Spaces-1).'})@=/ conceal cchar=¦ contained containedin=Indent'
"                execute 'syntax match IndentLevel /\v(^(\s{'.(Spaces).'})+)@<=\s(\s{'.(Spaces-1).'})@=/ conceal cchar=¦ contained containedin=Indent'
"            endif
"
"            setlocal conceallevel=1
"            nnoremap <silent> <F2> :let &conceallevel = ( &conceallevel == 1 ? 0 : 1 )<CR>
"        endfunction
"
"        augroup code_prettyer
"            autocmd!
"            autocmd BufReadPost,FileReadPost,BufNewFile * call CodePretty()
"            autocmd ColorScheme gruvbox call CodePrettyColors()
"        augroup end
"    endif
"endif
"


"=============================================================================
" Presistent_Undo {
"=============================================================================
if exists('s:UsePresistent_Undo') && has('persistent_undo') && exists("*mkdir")
    "colorscheme default
    let &undodir= expand(vimDir.'/undo')
    silent! call mkdir(&undodir)      " Create dir if needed
    set undolevels=1000         " How many undos
    set undoreload=5000         " number of lines to save for undo
    set undofile                " Use a undofile
endif
" } ===


"=============================================================================
" Small Support Functions {
"=============================================================================
command! TrimFile silent! %s/\s\+$//g | echom 'Trailing Space(s) Trimmed'

" sudo write current file
cnoremap w!! w !sudo tee % >/dev/null
" } ==




"=================================================================
" Testing Area for new stuff {
"=================================================================
" Allow the menu in Term mode
if !has("gui_running")
    source $VIMRUNTIME/menu.vim
    set wildmenu
    set cpoptions-=<
    set wildcharm=<C-Z>
    map <F4> :emenu <C-Z>
endif
" } ===





"nnoremap <C-w><Del> :close
"nnoremap <C-w><BS> :close
"nnoremap <C-w>| vsp
"nnoremap <C-w>- sp



" Tabs CTRL Page Down and PAGE UP



" Mappings for Arrow Keys Tabs
"noremap <C-Right> <Esc>:tabnext<CR>
"noremap <C-Left>  <Esc>:tabprevious<CR>
"inoremap <C-Right> <Esc>:tabnext<CR>i
"inoremap <C-Left>  <Esc>:tabprevious<CR>i

" check this one?
map <C-S-Right> <C-W>l<C-W>_
map <C-S-Left> <C-W>h<C-W>_


"nmap <C-S-Right> <Esc><c-w>l
"nmap <C-S-Left> <Esc><c-w>h
"nmap <C-S-Up> <Esc><c-w>k
"nmap <C-S-Down> <Esc><c-w>j

" Easier moving of code block indents Try to go into
" visual mode (v), then select several lines of code here and
" then press ``>`` several times.
vnoremap < <gv
vnoremap > >gv

noremap <silent> <leader>/ :nohlsearch<CR>


"=================================================================
" Clipboard
"=================================================================
if has('clipboard')
    set clipboard=unnamed
endif


"

"=================================================================
" Return to the last position in the file
"=================================================================
if !exists(
augroup return_file_postion
    autocmd!
    au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$")
                \ | exe "normal g'\"" | endif
augroup END

