" This is BeyondIM's vim config.

" Environment {{{1

    " Base {{{2
        " Enable no Vi compatible commands
        set nocompatible
        " Set viminfo path
        set viminfo+=n$HOME/.vimdb/.viminfo
        " Check system
        let g:isWin = has('win32') || has('win64')
        let g:isMac = has('mac') || has('macunix')
        " Remove all autocommands to avoid sourcing them twice
        autocmd!
    " }}}2

    " Windows Compatible {{{2
        if g:isWin
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }}}2

    " Runtimepath render {{{2
        runtime bundle/vim-pathogen/autoload/pathogen.vim
        let g:pathogen_disabled = []
        if !has('gui_running')
            call add(g:pathogen_disabled, 'vim-util')
        endif
        execute pathogen#infect()

        set runtimepath+=$HOME/.vim/scripts/scriptbundle/
        " Set reverse proxy server or http, socks proxy if can't access vim official site
        " let g:vimSiteReverseProxyServer = 'http://vim.wendal.net'
        " let g:curlProxy = 'socks://127.0.0.1:8888'
        call scriptbundle#rc()
        " yankring
        Script '1234'
        " mark
        Script '2666'
        " matchit
        Script '39'
        " mayansmoke colorscheme
        Script '3065', {'subdir':'colors'}
    " }}}2

" }}}1


" General {{{1

    " Basic {{{2
        filetype plugin indent on
        " Enable syntax highlighting
        syntax on
        " Set how many lines of history VIM has to remember
        set history=500
        " Set to auto read when a file is changed from the outside
        set autoread
        " A buffer becomes hidden when it is abandoned
        set hidden
        " Don't redraw while executing macros (good performance config)
        set lazyredraw
        " For regular expressions turn magic on
        set magic
        " Set utf-8 as standard encoding
        set encoding=utf-8
        set fileencoding=utf-8
        set fileencodings=utf-8,prc,latin1
        scriptencoding utf-8
        " Use Unix as the standard file type
        set fileformats=unix,dos,mac
        " Make a backup before overwriting a file
        set backup
        " Saves undo history when writing buffer to file and restores on buffer read
        if has('persistent_undo')
            set undofile
        endif
        " Disable beep and flash
        set noerrorbells visualbell t_vb=
        " With a map leader it's possible to do extra key combinations
        let g:maplocalleader="\\"
        let g:mapleader=","
        let mapleader=","
    " }}}2

    " UI {{{2
        " Set number
        set number
        set numberwidth=6
        " Minimum lines to keep above and below cursor
        set scrolloff=3
        " Turn on the wild menu, show list instead of just completing
        set wildmenu
        " Ignore custom files
        set wildignore+=*/.git/*,*/.DS_Store
        " Always show current position
        set ruler
         " Always has a status line
        set laststatus=2
        set statusline=[#%n]%(\ %{STLSegment1()}%)
        set statusline+=%(\ %{STLSegment2()}%)
        set statusline+=%(\ %{STLSegment3()}%)
        if exists(':SyntasticCheck')
            set statusline+=%(\ %{SyntasticStatuslineFlag()}%)
        endif
        set statusline+=%=
        set statusline+=%(%y\ %)
        set statusline+=L:\ %l/%L[%p%%]\ C:\ %c
        " Configure backspace so it acts as it should act
        set backspace=eol,start,indent
        set whichwrap+=<,>,h,l
        " Ignore case when searching
        set ignorecase
        " Set search highlighting
        set hlsearch
        " When searching try to be smart about cases
        set smartcase
        " Makes search act like search in modern browsers
        set incsearch
        " Wrap long lines
        set wrap
        " Show matching brackets when text indicator is over them
        set showmatch
        set matchtime=3
        " Specifies for which type of commands folds will be opened
        set foldopen=block,hor,insert,mark,percent,quickfix,search,tag,undo
        " Jump to the first open window that contains the specified buffer when switching
        set switchbuf=useopen
        " Allow virtual editing in Visual block mode
        set virtualedit+=block
        " Abbrev. of messages (avoids 'hit enter')
        set shortmess+=filmnrxoOtT
        " Don't show mode
        set noshowmode
        " Pause listings when the screen is full
        set more
        " Start a dialog when a command fails
        set confirm
        " Ignore changes in amount of white space
        set diffopt-=iwhite
        " Recognize numbered lists when autoindenting
        set formatoptions+=n
        " Use second line of paragraph when autoindenting
        set formatoptions+=2
        " Don't break long lines in insert mode
        set formatoptions+=l
        " Don't break lines after one-letter words, if possible
        set formatoptions+=1
        " Don't continue comments when pushing o/O
        set formatoptions-=o
        " Don't show the preview window
        set completeopt-=preview
        set t_co=256
        colorscheme molokai

    " }}}2

    " Formatting {{{2
        " Use spaces instead of tabs
        set expandtab
        " Be smart when using tabs
        set smarttab
        " 1 tab == 4 spaces
        set shiftwidth=4
        set tabstop=4
        set softtabstop=4
        " Auto indent
        set autoindent
        " Smart indent
        set smartindent
        " Don't show listchars by default
        set nolist
        " Highlight problematic whitespace
        set listchars=tab:»-,trail:·,eol:¬,nbsp:×,precedes:«,extends:»
        " String to put at the start of lines that have been wrapped
        set showbreak=Г
    " }}}2

" }}}1


" Commands, key mapping {{{1

    " Commands {{{2
        " Highlight current line and cursor when in insert mode
        autocmd InsertLeave * set nocursorline
        autocmd InsertEnter * set cursorline

        " Fast source $MYVIMRC
        autocmd BufWritePost .vimrc nested source $MYVIMRC

        " Return to last edit position when opening files
        autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g`\"" | endif

        " OmniComplete
        autocmd filetype * if exists('+omnifunc') && empty(&omnifunc) |
                    \setlocal omnifunc=syntaxcomplete#Complete |
                    \endif

        " Customize indent style
        autocmd FileType html,xhtml,css,javascript,ruby,eruby setlocal tabstop=2 shiftwidth=2 softtabstop=2

        " Resize splits when the window is resized
        autocmd VimResized * execute "normal! \<c-w>="

        " Diff orig file
        if !exists(":DiffOrig")
            command DiffOrig vnew | set buftype=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
        endif

        " }}}2

    " Key mappings {{{2
        " Wrapped lines goes down/up to next row, rather than next line in file
        nnoremap j gj
        nnoremap k gk
        " Visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv
        " Easier movement between windows
        nnoremap <LocalLeader>h <C-W>h<C-W>_
        nnoremap <LocalLeader>j <C-W>j<C-W>_
        nnoremap <LocalLeader>k <C-W>k<C-W>_
        nnoremap <LocalLeader>l <C-W>l<C-W>_

        " Keep search matches in the middle of the window.
        nnoremap n nzzzv
        nnoremap N Nzzzv

        " Fast saving
        nnoremap <Leader>w :<C-U>w!<CR>

        " Toggle search highlighting
        nnoremap <silent> <LocalLeader>/ :set hlsearch! hlsearch?<CR>

        " Invert 'foldenable'
        nnoremap <LocalLeader>= :set foldenable! foldenable?<CR>

        " Quickly set foldlevel
        nnoremap <LocalLeader>0 :set foldlevel=0<CR>
        nnoremap <LocalLeader>1 :set foldlevel=1<CR>
        nnoremap <LocalLeader>2 :set foldlevel=2<CR>
        nnoremap <LocalLeader>3 :set foldlevel=3<CR>
        nnoremap <LocalLeader>4 :set foldlevel=4<CR>
        nnoremap <LocalLeader>5 :set foldlevel=5<CR>
        nnoremap <LocalLeader>6 :set foldlevel=6<CR>
        nnoremap <LocalLeader>7 :set foldlevel=7<CR>
        nnoremap <LocalLeader>8 :set foldlevel=8<CR>
        nnoremap <LocalLeader>9 :set foldlevel=9<CR>

        " Toggle wrap lines
        nnoremap <silent> <F2> :set wrap! wrap?<CR>

        " Toggle listchars
        nnoremap <silent> <F3> :set list! list?<CR>
        imap <F3> <C-O><F3>
        xmap <F3> <Esc><F3>gv

        " Toggle ignore whitespace when diff
        nnoremap <LocalLeader>td :<C-U>if &diffopt=~#'iwhite'<BAR>set diffopt-=iwhite<BAR>
                    \else<BAR>set diffopt+=iwhite<BAR>
                    \endif<BAR>
                    \set diffopt?<CR>

        " Don't jump when using * for search
        nnoremap * *<c-o>

        " Search for selected text, forwards or backwards.
        vnoremap <silent> * :<C-U>
                    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                    \gvy/<C-R><C-R>=substitute(escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                    \gV:call setreg('"', old_reg, old_regtype)<CR>
        vnoremap <silent> # :<C-U>
                    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                    \gvy?<C-R><C-R>=substitute(escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                    \gV:call setreg('"', old_reg, old_regtype)<CR>

        " Substitute visual selection
        xnoremap & "*y<Esc>:<c-u>%s/<c-r>=substitute(escape(@*, '\/.*$^~['), "\n", '\\n', "g")<CR>//gc<LEFT><LEFT><LEFT>

        " Mapping arrow keys when running tmux
        if &term =~ '^screen' && exists('$TMUX')
            " tmux will send xterm-style keys when xterm-keys is on
            execute "set <xUp>=\e[1;*A"
            execute "set <xDown>=\e[1;*B"
            execute "set <xRight>=\e[1;*C"
            execute "set <xLeft>=\e[1;*D"
        endif
    " }}}2

" }}}1


" Plugins {{{1

    " NERDTree {{{2
        let NERDTreeChDirMode = 2
        let s:normalExts = ''
        let s:winExts = ''
        let NERDTreeIgnore=['\c\.\(lib\|so\|obj\|pdf\|jpe\=g\|png\|gif\|zip\|rar\|7z\|z\|bz2\|tar\|gz\|tgz\)$',
                    \'\c\.\(exe\|com\|dll\|ocx\|drv\|sys\|docx\=\|xlsx\=\|pptx\=\)$']
        let NERDTreeBookmarksFile = $HOME.'/.vimdb/.NERDTreeBookmarks'
        let NERDTreeAutoDeleteBuffer = 1
        nnoremap <silent> <Leader>nn :<C-U>NERDTreeToggle<CR>
    " }}}2

    " CtrlP {{{2
        nnoremap <silent> <Leader>ff :<C-U>CtrlP<CR>
        nnoremap <silent> <Leader>fm :<C-U>CtrlPMRU<CR>
        nnoremap <silent> <Leader>b :<C-U>CtrlPBuffer<CR>
        let g:ctrlp_custom_ignore = {
                    \'dir' : '\c^\(c:\\Windows\\\|c:\\Users\\[^\\]\+\\\)',
                    \'file' : '\c\.\(lib\|so\|obj\|pdf\|jpe\=g\|png\|gif\|zip\|rar\|7z\|z\|bz2\|tar\|gz\|tgz\|exe\|com\|dll\|ocx\|drv\|sys\|docx\=\|xlsx\=\|pptx\=\)$'
                    \}
        let g:ctrlp_cache_dir = $HOME.'/.vimdb/ctrlp'
    " }}}2

    " YankRing {{{2
        let g:yankring_history_dir = $HOME.'/.vimdb'
        nnoremap <silent> <Leader>y :YRGetElem<CR>
        function! YRRunAfterMaps()
            nnoremap <silent> Y :<C-U>YRYankCount 'y$'<CR>
        endfunction
    " }}}2

    " Gundo {{{2
        nnoremap <Leader>u :GundoToggle<CR>
        let g:gundo_width = 30
        let g:gundo_preview_bottom = 1
        let g:gundo_tree_statusline = 'Gundo'
        let g:gundo_preview_statusline = 'Gundo Preview'
    " }}}2

    " Tagbar {{{2
        nnoremap <silent> <Leader>t :TagbarToggle<CR>
        if g:isWin
            let g:tagbar_ctags_bin = $HOME.'/bin/ctags.exe'
            let g:tagbar_type_javascript = { 'ctagsbin' : $HOME.'/bin/jsctags.bat' }
            let g:tagbar_systemenc = 'cp936'
        endif
        let g:tagbar_autofocus = 1
        let g:tagbar_type_markdown = {
                    \ 'ctagstype' : 'markdown',
                    \ 'kinds' : [
                    \ 'h:Heading_L1',
                    \ 'i:Heading_L2',
                    \ 'k:Heading_L3'
                    \ ]
                    \ }
        let g:tagbar_type_ruby = {
                    \ 'kinds' : [
                    \ 'm:modules',
                    \ 'c:classes',
                    \ 'd:describes',
                    \ 'C:contexts',
                    \ 'f:methods',
                    \ 'F:singleton methods'
                    \ ]
                    \ }
        let g:tagbar_type_css = {
                    \ 'ctagstype' : 'Css',
                    \ 'kinds'     : [
                    \ 'c:classes',
                    \ 's:selectors',
                    \ 'i:identities'
                    \ ]
                    \ }
    " }}}2

    " Neocomplete {{{2
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#use_vimproc = 1
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#data_directory = $HOME.'/.vimdb/.neocomplete'
        let s:ignoredBufs = '^\[.\+\]\|__.\+__\|NERD_tree_\|ControlP'
        let g:neocomplete#lock_buffer_name_pattern = s:ignoredBufs
        let g:neocomplete#force_overwrite_completefunc = 1

        " Define keyword, for minor languages
        if !exists('g:neocomplete_keyword_patterns')
            let g:neocomplete_keyword_patterns = {}
        endif
        let g:neocomplete_keyword_patterns['default'] = '\h\w*'        

        " key mappings
        inoremap <expr><C-g> neocomplete#undo_completion()
        inoremap <expr><C-l> neocomplete#complete_common_string()
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

        inoremap <silent><expr><CR> neosnippet#expandable() ? neosnippet#mappings#expand_impl() :
                    \ pumvisible() ? neocomplete#close_popup() : "\<CR>"

        inoremap <silent><expr><C-j> neosnippet#jumpable() ? neosnippet#mappings#jump_impl() : "\<ESC>"
        snoremap <silent><expr><C-j> neosnippet#jumpable() ? neosnippet#mappings#jump_impl() : "\<ESC>"

        " Enable omni completion
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

        if !exists('g:neocomplete#force_omni_input_patterns')
            let g:neocomplete#force_omni_input_patterns = {}
        endif
        let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

        " Disable neosnippet-snippets
        let g:neosnippet#disable_runtime_snippets = {'_' : 1}

        " For snippet_complete marker
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif

        "Use snipmate snippets
        let g:neosnippet#snippets_directory=$HOME.'/.vim/bundle/vim-snippets/snippets'
        let g:neosnippet#enable_snipmate_compatibility = 1
    " }}}2

    " Syntastic {{{2
        let g:syntastic_stl_format = '[L:%F, %E{Err:%e}%B{ }%W{Warn:%w}]'
        let g:syntastic_javascript_checkers=['jslint']
        let g:syntastic_ruby_checkers=['mri', 'rubocop']
    " }}}2

    " Mark {{{2
        let g:mwDefaultHighlightingPalette = 'extended'
        nmap <Leader>mm <Plug>MarkSet
        xmap <Leader>mm <Plug>MarkSet
        nmap <Leader>mr <Plug>MarkRegex
        xmap <Leader>mr <Plug>MarkRegex
        nmap <Leader>mn <Plug>MarkClear
        nmap <Leader>mt <Plug>MarkToggle
        nmap <Leader>mc <Plug>MarkAllClear
        nmap <Leader>m* <Plug>MarkSearchCurrentNext
        nmap <Leader>m# <Plug>MarkSearchCurrentPrev
        nmap <Leader>m/ <Plug>MarkSearchAnyNext
        nmap <Leader>m? <Plug>MarkSearchAnyPrev
        nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
        nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
    " }}}2

    " Vim-javascript {{{2
        let g:html_indent_inctags = "html,body,head,tbody"
        let g:html_indent_script1 = "inc"
        let g:html_indent_style1 = "inc"
    " }}}2

    " Vim-ruby {{{2
        let g:rubycomplete_rails = 1
        let g:rubycomplete_classes_in_global = 1
        let g:rubycomplete_buffer_loading = 1
        let g:rubycomplete_include_object = 1
        let g:rubycomplete_include_objectspace = 1
    " }}}2

" }}}1


" Functions {{{1

    " Remove trailing whitespaces and ^M chars {{{2
        function! StripTrailingWhitespace()
            let _s=@/
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            let @/=_s
            call cursor(l, c)
        endfunction

        autocmd filetype javascript,ruby autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    " }}}2

    " Show foldcolumn when folding exists {{{2
        function! UpdateFoldcolumn(...)
            let defaultInterval = 5
            let interval = a:0 > 0 ? a:1 : defaultInterval
            let foldcolumnWidth = a:0 > 1 ? a:2 : ''
            if !exists('b:savedTime')
                let b:savedTime = localtime()
            elseif localtime() - b:savedTime >= interval
                silent! execute 'call SetFoldcolumn(' . foldcolumnWidth . ')'
                let b:savedTime = localtime()
            endif
        endfunction

        function! SetFoldcolumn(...)
            let defaultWidth = 3
            let width = a:0 > 0 ? a:1 : defaultWidth
            let lineNum=1
            while lineNum <= line("$")
                if foldlevel(lineNum)
                    silent! execute "set foldcolumn=" . width
                    return
                endif
                let lineNum = lineNum + 1
            endwhile
            silent! execute "set foldcolumn=0"
        endfunction

        autocmd BufWinEnter,BufLeave * call SetFoldcolumn()
        autocmd CursorHold * call UpdateFoldcolumn()
    " }}}2

    " Toggle fold state between closed and opened {{{2
        function! ToggleFold()
            if !foldlevel('.')
                normal! l
            else
                if foldclosed('.') < 0
                    . foldclose
                else
                    . foldopen
                endif
            endif
            echo
        endfun

        nnoremap <space> :<C-U>call ToggleFold()<CR>
    " }}}2

    " Auto open folding in predefined range around cursor when inserting {{{2
        function! OpenFoldWhenInserting(range)
            let l:range = a:range+0
            let l:line = line('.')
            let l:oldWinline = winline()
            silent! execute (l:line-l:range).','.(l:line+l:range).'foldopen!'
            let l:newWinline = winline()
            let l:scrollNum = l:newWinline-l:oldWinline
            if l:scrollNum < 0
                while l:scrollNum < 0
                    call feedkeys("\<C-x>\<C-y>")
                    let l:scrollNum+=1
                endwhile
            endif
            if l:line > &scrolloff && l:scrollNum > 0
                while l:scrollNum > 0
                    call feedkeys("\<C-x>\<C-e>")
                    let l:scrollNum-=1
                endwhile
            endif
        endfunction

        autocmd InsertEnter * call OpenFoldWhenInserting(10)
    " }}}2

    " Customize foldtext {{{2
        function! CustomFoldtext()
            let indent = repeat(' ', indent(v:foldstart))
            let startLine = getline(v:foldstart)
            let endLine = getline(v:foldend)
            let windowWidth = winwidth(0) - &foldcolumn - &numberwidth - (s:YepNopeSigns()+0 ? 2 : 0)
            let foldSize = v:foldend - v:foldstart + 1
            let foldSizeStr = ' ' . foldSize . ' lines '
            let foldPercentage = printf("[%.1f", (foldSize * 1.0)/line('$') * 100) . "%] "
            let foldLevelStr = repeat('+--', v:foldlevel)
            " fold comments when setting foldmarker as /\*,\*/
            if !match(startLine, '^\s*/\*\([\*\\/# ]\(\*/\)\@!\)*\s*$') &&
                        \!match(endLine, '^\s*\(\(/\*\)\@<![\*\\/# ]\)*\*/\s*$')
                let temp =matchstr(startLine, '^\(\s*/\*\)\ze\(\([\*\\/# ]\(\*/\)\@!\)*\)')
                let startStr = substitute(temp, '^\t\+', indent, '')
                let text = startStr . ' ... */'
                let lineNum = v:foldstart + 1
                while lineNum < v:foldend
                    let curLine = getline(lineNum)
                    let comment = s:GetRealStr(curLine, '[0-9a-zA-Z_-]')
                    if !empty(comment)
                        let text = startStr . ' ' . comment . ' */'
                        break
                    endif
                    let lineNum = lineNum + 1
                endwhile
                let expansionWidth = windowWidth - strwidth(text.foldSizeStr.foldPercentage.foldLevelStr)
                if expansionWidth > 0
                    let expansionStr = repeat(".", expansionWidth)
                    return text.expansionStr.foldSizeStr.foldPercentage.foldLevelStr
                else
                    let comment = substitute(comment, '.\{' . abs(expansionWidth) . '}$', '', '')
                    let text = startStr . ' ' . comment . ' */'
                    return text.foldSizeStr.foldPercentage.foldLevelStr
                endif
            endif
            " fold codes when setting foldmarker as {,}
            if match(startLine, '{\+\d\=\s*$') != -1 && match(endLine, '}\+\d\=\s*$') != -1
                let startBracket = matchstr(startLine, '{\+\d\=\ze\s*$')
                let temp = substitute(startLine, '{\+\d\=\s*$', '', '')
                let startStr = substitute(temp, '^\t\+', indent, '')
                let endBracket = matchstr(endLine, '}\+\d\=\ze\s*$')
                let text = startStr . startBracket . '...' . endBracket
                let expansionWidth = windowWidth - strwidth(text.foldSizeStr.foldPercentage.foldLevelStr)
                if expansionWidth > 0
                    let expansionStr = repeat(".", expansionWidth)
                    return text.expansionStr.foldSizeStr.foldPercentage.foldLevelStr
                else
                    let startStr = substitute(startStr, '.\{' . abs(expansionWidth) . '}$', '', '')
                    let text = startStr . startBracket . '...' . endBracket
                    return text.foldSizeStr.foldPercentage.foldLevelStr
                endif
            endif
        endfunction

        function! s:GetRealStr(str, ...)
            let style = a:0 > 0 ? a:1 : '\w'
            let startIdx = match(a:str, style)
            if startIdx == -1
                return
            endif
            let endIdx = strlen(a:str) - 1
            while match(a:str[endIdx], style) == -1
                let endIdx -= 1
            endwhile
            return strpart(a:str, startIdx, endIdx-startIdx+1)
        endfunction

        function! s:YepNopeSigns()
            redir => message
            silent! execute 'sign place buffer=' . bufnr('%')
            redir END
            if match(message, 'id=\d\+') != -1
                return 1
            else
                return
            endif
        endfunction

        " Set foldtext
        autocmd filetype vim setlocal foldtext=CustomFoldtext()

        " Quickly set foldmethod
        nnoremap <silent> <LocalLeader>fc :<C-U>setlocal foldmethod=marker foldmarker={,} foldtext=CustomFoldtext()<CR>
        nnoremap <silent> <LocalLeader>fv :<C-U>setlocal foldmethod=marker foldmarker=/\*,\*/ foldtext=CustomFoldtext()<CR>
    " }}}2

    " Delete buffer while keeping window layout {{{2
        function! s:CloseCurrentBuffer(bang, buffer)
            if empty(a:buffer)
                let bTarget = bufnr('%')
            elseif a:buffer =~ '^\d\+$'
                " When a:buffer doesn't exist as number, try as string
                let bTarget = bufnr(a:buffer+0)>0 ? bufnr(a:buffer+0) : bufnr(a:buffer)
            else
                let bTarget = bufnr(a:buffer)
            endif
            if bTarget < 0
                echohl ErrorMsg
                echo 'No matching buffer for ' . a:buffer
                echohl None
                return
            endif
            if empty(a:bang) && getbufvar(bTarget, '&modified')
                echohl WarningMsg
                echo 'No write since last change for buffer ' . bTarget . ' (use :DeleteBuffer!)'
                echohl None
                return
            endif
            let wCurrent = winnr()
            let wNums = filter(range(1, winnr('$')), "winbufnr(v:val) == " . bTarget)
            if len(wNums) > 0
                for w in wNums
                    " Check if exists buflisted alternative buffer
                    let bAlternative = -1
                    " Check if exists buflisted non-alternative buffer
                    let bBuflistedMatch = -1
                    " Check if exists nobuflisted unnamed buffer
                    let bNobuflistedMatch = -1
                    execute w . 'wincmd w'
                    for bufNum in range(1, bufnr('$'))
                        if buflisted(bufNum) && bufnr(bufNum) != bTarget
                            if bufnr(bufNum) == bufnr('#')
                                let bAlternative = bufnr(bufNum)
                            else
                                let bBuflistedMatch = bufnr(bufNum)
                            endif
                        endif
                        if bufloaded(bufNum) && !buflisted(bufNum) && !strlen(bufname(bufNum)) && bufnr(bufNum) != bTarget
                            let bNobuflistedMatch = bufnr(bufNum)
                        endif
                    endfor
                    if bAlternative > 0
                        execute 'buffer ' . bAlternative
                        continue
                    endif
                    if bBuflistedMatch > 0
                        execute 'buffer ' . bBuflistedMatch
                        continue
                    endif
                    if bNobuflistedMatch > 0
                        execute 'buffer ' . bNobuflistedMatch
                    else
                        execute 'enew' . a:bang
                    endif
                    setlocal buflisted
                    " Delete the unnamed buffer when switch to other one
                    setlocal bufhidden=delete
                endfor
            endif
            silent! execute 'bdelete' . a:bang . ' ' . bTarget
            execute wCurrent . 'wincmd w'
        endfunction

        function! s:CloseAllHiddenBuffers()
            let total = 0
            let wCurrent = winnr()
            for w in range(1, winnr('$'))
                execute w . 'wincmd w'
                for bufNum in range(1, bufnr('$'))
                    if bufloaded(bufNum) && !buflisted(bufNum) && match(bufname(bufNum), s:ignoredBufs) == -1
                        execute 'bwipeout! ' . bufNum
                        let total = total + 1
                    endif
                endfor
            endfor
            execute wCurrent . 'wincmd w'
            if total > 0
                echo total . ' hidden buffers deleted.'
            else
                echo 'No hidden buffers exist.'
            endif
        endfunction

        command! -bang -complete=buffer -nargs=? CloseCurrentBuffer call s:CloseCurrentBuffer('<bang>', '<args>')
        nnoremap <silent> <LocalLeader>cc :CloseCurrentBuffer<CR>

        command! -bang CloseAllHiddenBuffers call s:CloseAllHiddenBuffers()
        nnoremap <silent> <LocalLeader>ca :CloseAllHiddenBuffers<CR>
    " }}}2

    " Remaps arrow keys to indent/unindent and add/remove blank lines {{{2
        function! s:DelEmptyLine(direction)
            let l:line = line('.')
            let l:col = col('.')
            if a:direction == '-'
                if l:line == 1
                    return
                endif
                if getline(l:line-1) =~ '^\s*$'
                    let l:oldWinline = winline()
                    .-1d
                    call cursor(l:line-1, l:col)
                    let l:newWinline = winline()
                    if l:newWinline < l:oldWinline
                        call feedkeys((l:oldWinline-l:newWinline)."\<C-y>")
                    endif
                endif
            endif
            if a:direction == '+'
                if l:line == line('$')
                    return
                endif
                if getline(l:line+1) =~ '^\s*$'
                    .+1d
                    call cursor(l:line, l:col)
                endif
            endif
        endfunction

        function! s:AddEmptyLine(direction)
            let l:line = line('.')
            let l:col = col('.')
            if a:direction == '-'
                let l:oldWinline = winline()
                call append(line('.')-1, '')
                call cursor(l:line+1, l:col)
                let l:newWinline = winline()
                if l:line > &scrolloff && l:newWinline > l:oldWinline
                    call feedkeys((l:newWinline-l:oldWinline)."\<C-e>")
                endif
            endif
            if a:direction == '+'
                call append(line('.'), '')
                call cursor(l:line, l:col)
            endif
        endfunction

        " normal mode
        nnoremap <silent> <S-Left> <<
        nnoremap <silent> <S-Right> >>
        nnoremap <silent> <S-Up> <Esc>:call <SID>AddEmptyLine('-')<CR>
        nnoremap <silent> <S-Down>  <Esc>:call <SID>AddEmptyLine('+')<CR>
        nnoremap <silent> <C-Up> <Esc>:call <SID>DelEmptyLine('-')<CR>
        nnoremap <silent> <C-Down> <Esc>:call <SID>DelEmptyLine('+')<CR>

        " visual mode
        vnoremap <silent> <S-Left> <gv
        vnoremap <silent> <S-Right> >gv
        vnoremap <silent> <S-Up> <Esc>:call <SID>AddEmptyLine('-')<CR>gv
        vnoremap <silent> <S-Down>  <Esc>:call <SID>AddEmptyLine('+')<CR>gv
        vnoremap <silent> <C-Up> <Esc>:call <SID>DelEmptyLine('-')<CR>gv
        vnoremap <silent> <C-Down> <Esc>:call <SID>DelEmptyLine('+')<CR>gv

        " insert mode
        inoremap <silent> <S-Left> <C-D>
        inoremap <silent> <S-Right> <C-T>
        inoremap <silent> <S-Up> <Esc>:call <SID>AddEmptyLine('-')<CR>a
        inoremap <silent> <S-Down> <Esc>:call <SID>AddEmptyLine('+')<CR>a
        inoremap <silent> <C-Up> <Esc>:call <SID>DelEmptyLine('-')<CR>a
        inoremap <silent> <C-Down> <Esc>:call <SID>DelEmptyLine('+')<CR>a
    " }}}2

    " Preview markdown files {{{2
        function! s:PreviewMarkdown()
            if !executable('pandoc')
                echohl ErrorMsg | echo 'Please install pandoc first.' | echohl None
                return
            endif
            if g:isWin
                let BROWSER_COMMAND = 'cmd.exe /c start ""'
            elseif g:isMac
                let BROWSER_COMMAND = 'open'
            endif
            let output_file = tempname() . '.html'
            let input_file = tempname() . '.md'
            let css_file = 'file://' . expand($HOME . '/.vimdb/pandoc/github.css', 1)
            " Convert buffer to UTF-8 before running pandoc
            let original_encoding = &fileencoding
            let original_bomb = &bomb
            silent! execute 'set fileencoding=utf-8 nobomb'
            " Generate html file for preview
            let content = getline(1, '$')
            let newContent = []
            for line in content
                let str = matchstr(line, '\(!\[.*\](\)\@<=.\+\.\%(png\|jpe\=g\|gif\)')
                if str != "" && match(str, '^https\=:\/\/') == -1
                    let newLine = substitute(line, '\(!\[.*\]\)(' . str . ')',
                                \'\1(file://' . escape(expand("%:p:h", 1), '\') . 
                                \(g:isWin ? '\\\\' : '/') . 
                                \escape(expand(str, 1), '\') . ')', 'g')
                else
                    let newLine = line
                endif
                call add(newContent, newLine)
            endfor
            call writefile(newContent, input_file)
            silent! execute '!pandoc -f markdown -t html5 -s -S -c "' . css_file . '" -o "' . output_file .'" "' . input_file . '"'
            call delete(input_file)
            " Change encoding back
            silent! execute 'set fileencoding=' . original_encoding . ' ' . original_bomb
            " Preview 
            silent! execute '!' . BROWSER_COMMAND . ' "' . output_file . '"'
            execute input('Press ENTER to continue...')
            echo
            call delete(output_file)
        endfunction

        nnoremap <silent> <LocalLeader>p :call <SID>PreviewMarkdown()<CR>
    " }}}2

    " Customize statusline {{{2
        function! STLSegment1()
            if &l:buftype == 'nofile'
                let l:str = '<Scratch>'
            elseif &l:buftype == 'quickfix'
                let l:str = '<quickfix>'
            elseif &l:buftype == 'help'
                let l:str = '<help>'
            elseif empty(&l:buftype)
                if expand("%:p:h", 1) == getcwd()
                    let l:str = expand("%:p", 1)
                else
                    let l:str = '<' . getcwd() . '> ' . expand("%:p:t", 1)
                endif
            endif
            return exists('l:str') ? l:str : ''
        endfunction

        function! STLSegment2()
            if &l:readonly
                if &l:modified
                    let l:str = '[RO,+]'
                else
                    let l:str = '[RO]'
                endif
            else
                if &l:modified
                    let l:str = '[+]'
                endif
            endif
            return exists('l:str') ? l:str : ''
        endfunction

        function! STLSegment3()
            if &l:fileencoding != 'utf-8' && !empty(&l:fileencoding)
                if &l:fileformat != 'unix'
                    let l:str = '[' . &l:fileencoding . ',' . &l:fileformat . ']'
                else
                    let l:str = '[' . &l:fileencoding . ']'
                endif
            else
                if &l:fileformat != 'unix'
                    let l:str = '[' . &l:fileformat . ']'
                endif
            endif
            return exists('l:str') ? l:str : ''
        endfunction

        function! s:GetOrigSTLColor()
            redir => s:origSTLColor
            silent! execute 'highlight StatusLine'
            redir END
            let s:origSTLColor = substitute(s:origSTLColor, '.*xxx\(.*\)$', '\1', '')
            let s:origSTLColor = substitute(s:origSTLColor, '\n', ' ', 'g')
            let s:origSTLColor = substitute(s:origSTLColor,'\s\+', ' ', 'g')
        endfunction

        function! s:RestoreOrigSTLColor()
            if !exists('s:origSTLColor')
                finish
            endif
            execute 'highlight StatusLine NONE'
            execute 'highlight StatusLine' . s:origSTLColor
        endfunction

        function! s:SetSTLColor(mode)
            if !exists('s:origSTLColor') || s:curColorsName != g:colors_name
                call s:GetOrigSTLColor()
                let s:curColorsName = exists('g:colors_name') ? g:colors_name : 'noColorsName'
            endif
            if a:mode ==# 'i'
                execute 'highlight StatusLine NONE'
                execute 'highlight StatusLine gui=Bold guifg=White guibg=Purple term=bold ctermfg=255 ctermbg=90'
            elseif a:mode =~# '\(r\|v\)'
                execute 'highlight StatusLine NONE'
                execute 'highlight StatusLine gui=Bold guifg=White guibg=Orange term=bold ctermfg=255 ctermbg=208'
            else
                call s:RestoreOrigSTLColor()
            endif
        endfunction

        autocmd InsertEnter * call s:SetSTLColor(v:insertmode)
        autocmd InsertLeave * call s:RestoreOrigSTLColor()
    "}}}2

    " Create directories for swap, backup, undo, view files if they don't exist {{{2
        function! s:InitializeDirectories()
            let parent = $HOME.'/.vimdb'
            " backupdir -- directory for backup files
            " viewdir -- directory for view files
            " directory -- directory for swap files
            " undodir -- directory for undo files
            let dirList = {'backupdir' : 'backup', 'viewdir' : 'view', 'directory' : 'swap'}
            if has('persistent_undo')
                let dirList['undodir'] = 'undo'
            endif
            for [settingName, dirName] in items(dirList)
                let dir = parent . '/' . dirName
                if isdirectory(dir)
                    execute 'set ' . settingName . '=' . escape(expand(dir, 1), '\ ')
                    continue
                else
                    if exists('*mkdir')
                        call mkdir(dir, 'p')
                        execute 'set ' . settingName . '=' . escape(expand(dir, 1), '\ ')
                    else
                        echohl WarningMsg | echo 'Unable to create directory ' . dir . ' ,try to create manually.' | echohl None
                    endif
                endif
            endfor
        endfunction

        call s:InitializeDirectories()
    " }}}2

    " Helper functions {{{2
        " Check file whether is readable
        function! s:CheckFileReadable(file)
            if !filereadable(a:file)
                silent! execute 'keepalt botright 1new'
                silent! execute 'edit ' . a:file
                silent! execute 'write!'
                silent! execute 'bwipeout!'
                silent! execute 'close!'
                if !filereadable(a:file)
                    echohl WarningMsg | echo a:file . " can't read!" | echohl None
                    return
                endif
            endif
        endfunction

        " Check file whether is writable
        function! s:CheckFileWritable(file)
            if !filewritable(a:file)
                echohl WarningMsg | echo a:file . " can't write!" | echohl None
                return
            endif
        endfunction
    " }}}2
" }}}1

" vim: set shiftwidth=4 tabstop=4 softtabstop=4 expandtab foldmethod=marker:
