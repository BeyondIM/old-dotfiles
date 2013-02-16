" vim: set shiftwidth=4 tabstop=4 softtabstop=4 expandtab foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
" Environment {{{1

    " Base {{{2
        " Important
        set nocompatible
        " Remove all autocommands to avoid sourcing them twice
        autocmd!
        " Set viminfo path
        set viminfo+=n$HOME/.cache/.viminfo
    " }}}2

    " Windows Compatible {{{2
        if has('win32') || has('win64')
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }}}2

    " Vundle {{{2
        filetype off
        set runtimepath+=$HOME/.vim/bundle/vundle/
        call vundle#rc()
        let g:vundle_default_git_proto = 'git'
        " basic
        Bundle 'gmarik/vundle'
        " colorscheme
        Bundle 'nanotech/jellybeans.vim'
        " enhancement
        Bundle 'kien/ctrlp.vim'
        Bundle 'myusuf3/numbers.vim'
        Bundle 'godlygeek/tabular'
        Bundle 'tpope/vim-surround'
        Bundle 'tpope/vim-repeat'
        Bundle 'vim-scripts/YankRing.vim'
        Bundle 'scrooloose/nerdtree'
        Bundle 'scrooloose/nerdcommenter'
        Bundle 'sjl/gundo.vim'
        " completion
        Bundle 'Shougo/vimproc'
        Bundle 'Shougo/neocomplcache'
        Bundle 'Shougo/neosnippet'
        Bundle 'honza/snipmate-snippets'
        " html
        Bundle 'othree/html5.vim'
        " css
        Bundle 'lepture/vim-css'
        " php
        Bundle 'spf13/PIV'
        " markdown
        Bundle 'tpope/vim-markdown'
        " gist
        Bundle 'mattn/webapi-vim'
        Bundle 'mattn/gist-vim'
        " tags
        Bundle 'mozilla/doctorjs'
        Bundle 'techlivezheng/phpctags'
        Bundle 'techlivezheng/tagbar-phpctags'
        Bundle 'majutsushi/tagbar'
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
        " Set utf8 as standard encoding
        set encoding=utf-8
        set fileencodings=utf-8,prc,latin1
        " Set zh_CN.utf-8 as the standard language
        language messages zh_CN.utf-8
        " Reload menu for showing in Chinese
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        " Use Unix as the standard file type
        set fileformats=unix,dos,mac
        " Set the directory name for swap file
        set directory+=$TMP//
        " No annoying sound on error
        set noerrorbells
        set novisualbell
        set t_vb=
        " With a map leader it's possible to do extra key combinations
        let mapleader=","
        let g:mapleader=","
    " }}}2

    " UI {{{2
        " Minimum lines to keep above and below cursor
        set scrolloff=3
        " Turn on the wild menu, show list instead of just completing
        set wildmenu
        " Ignore custom files
        set wildignore=*/.git/*,*/.DS_Store
        " Always show current position
        set ruler
        " Always has a status line
        set laststatus=2
        set statusline=[Buffer:\ %n]\ %f\ %m\ %r
        set statusline+=\ [%{strlen(&fileencoding)?&fileencoding:'none'},%{&fileformat}]
        set statusline+=%=Line:\ %l/%L[%p%%]\ Col:\ %c
        " Configure backspace so it acts as it should act
        set backspace=eol,start,indent
        set whichwrap+=<,>,h,l
        " Ignore case when searching
        set ignorecase
        " When searching try to be smart about cases
        set smartcase
        " Makes search act like search in modern browsers
        set incsearch
        " Show matching brackets when text indicator is over them
        set showmatch
        " Jump to the first open window that contains the specified buffer when switching
        set switchbuf=useopen
        " Pause listings when the screen is full
        set more
        " Start a dialog when a command fails
        set confirm
        " Highlight current line when in insert mode
        autocmd InsertLeave * set nocursorline
        autocmd InsertEnter * set cursorline
        " Set foldtext
        set foldtext=CustomFoldtext()
        " Show foldcolumn when exists folding
        autocmd BufWinEnter,BufLeave * call SetFoldcolumn()
        autocmd CursorHold * call UpdateFoldcolumn()

        " Set extra options when running in GUI mode
        if has("gui_running")
            " use console dialogs
            set guioptions+=c
            " don't auto-copy selection to * register
            set guioptions-=a
            " don't use gui tabs
            set guioptions-=e
            " don't show menubar
            set guioptions-=m
            " don't show toolbar
            set guioptions-=T
            " disable scrollbars
            set guioptions-=r
            set guioptions-=R
            set guioptions-=l
            set guioptions-=L
            set t_co=256
            set guifont=Consolas:h12:cANSI
            set guifontwide=Yahei_Mono:h11
            " don't use ALT key to activate menu
            set winaltkeys=no
        endif

        " Colorscheme
        set background=dark
        try
            colorscheme jellybeans
        catch
        endtry
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
        " Highlight problematic whitespace
        set listchars=tab:›-,eol:¬,trail:‹,nbsp:.
        " Remove trailing whitespaces and ^M chars
        autocmd FileType * autocmd BufWritePre <buffer> call StripTrailingWhitespace()
        " Custom indent style
        autocmd FileType php,javascript,html,xhtml,css setlocal tabstop=2 shiftwidth=2 softtabstop=2
    " }}}2

" }}}1


" Plugins {{{1

    " Numbers {{{2
        nnoremap <F4> :NumbersToggle<CR>
    " }}}2

    " NERDTree {{{2
        let NERDTreeChDirMode = 2
        let NERDTreeIgnore=['\~$', '\c\.\(exe\|com\|so\|dll\|sys\|ocx\|dat\|drv\|rom\|ax\|db\|pdf\|jpe\=g\|png\|gif\|docx\=\|xlsx\=\|pptx\=\|dwg\|zip\|rar\|7z\)$']
        let NERDTreeBookmarksFile = $HOME . '/.cache/.NERDTreeBookmarks'
        let NERDTreeDirArrows = 1
        let NERDTreeAutoDeleteBuffer = 1
        nnoremap <silent> <leader>nb :<C-U>call SmartNERDTreeBookmark()<CR>
        nnoremap <silent> <Leader>nn :<C-U>NERDTreeToggle<CR>
    " }}}2

    " CtrlP {{{2
        nnoremap <silent> <leader>ff :CtrlP<CR>
        nnoremap <silent> <Leader>fr :CtrlPMRU<CR>
        nnoremap <silent> <leader>b :CtrlPBuffer<CR>
        let g:ctrlp_custom_ignore = {
                    \ 'dir' : '\c^\(c:\\Windows\|c:\\Users\\Administrator\)',
                    \ 'file' : '\c\.\(exe\|com\|so\|dll\|sys\|ocx\|dat\|drv\|rom\|ax\|db\|pdf\|jpe\=g\|png\|gif\|docx\=\|xlsx\=\|pptx\=\|dwg\|zip\|rar\|7z\)$',
                    \ }
        let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
    " }}}2

    " YankRing {{{2
        let g:yankring_history_dir = $HOME.'/.cache'
        nnoremap <silent> <Leader>y :YRGetElem<CR>
        function! YRRunAfterMaps()
            nnoremap <silent> Y :<C-U>YRYankCount 'y$'<CR>
        endfunction
    " }}}2

    " PIV {{{2
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
    " }}}2

    " Gundo {{{2
        nnoremap <F5> :GundoToggle<CR>
    " }}}2

    " Neocomplcache {{{2
        let g:acp_enableAtStartup = 0
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_smart_case = 1
        " Use camel case completion
        let g:neocomplcache_enable_camel_case_completion = 1
        " Use underscore completion
        let g:neocomplcache_enable_underbar_completion = 1
        let g:neocomplcache_use_vimproc = 1
        let g:neocomplcache_min_syntax_length = 3
        let g:neocomplcache_temporary_dir = $HOME.'/.cache/.neocon'

        " Define keyword, for minor languages
        if !exists('g:neocomplcache_keyword_patterns')
            let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

        " key-mappings
        inoremap <expr><C-g> neocomplcache#undo_completion()
        inoremap <expr><C-l> neocomplcache#complete_common_string()
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

        inoremap <silent><expr><CR> neosnippet#expandable() ? neosnippet#expand_impl() :
                    \ pumvisible() ? neocomplcache#close_popup() : "\<CR>"

        inoremap <silent><expr><C-j> neosnippet#jumpable() ? neosnippet#jump_impl() : "\<ESC>"
        snoremap <silent><expr><C-j> neosnippet#jumpable() ? neosnippet#jump_impl() : "\<ESC>"

        snoremap <C-h> "\<C-h>"
        snoremap <BS> "\<C-h>"

        " Enable omni completion
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

        " For snippet_complete marker
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif

        "Use snipmate snippets
        let g:neosnippet#snippets_directory='$HOME/.vim/bundle/snipmate-snippets/snippets'
        let g:neosnippet#enable_snipmate_compatibility = 1
    " }}}2

    " Tagbar {{{2
        nnoremap <silent> <leader>t :TagbarToggle<CR>
        let g:tagbar_ctags_bin = '$HOME/bin/ctags58/ctags.exe'
        let g:tagbar_systemenc = 'cp936'
        let g:tagbar_autofocus = 1
        let g:tagbar_type_javascript = { 'ctagsbin' : '$HOME/bin/jsctags.bat' }
        let g:tagbar_phpctags_bin = '$HOME/.vim/bundle/phpctags/phpctags.php'
    " }}}2

" }}}1


" Misc {{{1

    " Helper key mapping {{{2
        noremap   <Up>     <NOP>
        noremap   <Down>   <NOP>
        noremap   <Left>   <NOP>
        noremap   <Right>  <NOP>
        " Wrapped lines goes down/up to next row, rather than next line in file
        nnoremap j gj
        nnoremap k gk
        " Visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv
        " Easier movement between windows
        nnoremap <M-h> <C-W>h
        nnoremap <M-j> <C-W>j
        nnoremap <M-k> <C-W>k
        nnoremap <M-l> <C-W>l
        " Change window size
        nnoremap <M->> <C-W>>
        nnoremap <M-<> <C-W><
        nnoremap <M-+> <C-W>+
        nnoremap <M--> <C-W>-
        nnoremap <M-=> <C-W>=
        " Other window command key mapping
        nnoremap <M-o> <C-W>o
        nnoremap <M-q> <C-W>q

        " Fast saving
        nnoremap <leader>w :<C-U>w!<CR>
        " Toggle search highlighting
        nnoremap <silent> <leader>/ :set hlsearch! hlsearch?<CR>
        " Quickly set foldlevel when zr/zm seems slowly
        nnoremap <silent> <Leader><Leader>l :<C-U>call SetFoldlevel(input("Enter foldlevel: "))<CR>
        " Toggle folds
        nnoremap <space> :<C-U>call ToggleFold()<CR>
        " Toggle wrap lines
        nnoremap <silent> <F2> :set wrap! wrap?<CR>
        " Toggle listchars
        nnoremap <silent> <F3> :set list! list?<CR>
        imap <F2> <C-O><F2>
        xmap <F2> <Esc><F2>gv
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
    " }}}2

    " Helper function {{{2
        " Fast source $MYVIMRC
        autocmd bufwritepost .vimrc source $MYVIMRC

        " Return to last edit position when opening files
        autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

        " Don't screw up folds when inserting text that might affect them, until leaving insert mode
        autocmd InsertEnter * if !exists('b:lastFoldMethod') | let b:lastFoldMethod=&foldmethod | setlocal foldmethod=manual | endif
        autocmd InsertLeave,WinLeave * if exists('b:lastFoldMethod') | let &l:foldmethod=b:lastFoldMethod | unlet b:lastFoldMethod | endif

        " Diff orig file
        if !exists(":DiffOrig")
            command DiffOrig vnew | set buftype=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
        endif

        " Strip whitespace
        function! StripTrailingWhitespace()
            let _s=@/
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            let @/=_s
            call cursor(l, c)
        endfunction

        " Update SetFoldcolumn function in a interval
        function! UpdateFoldcolumn(...)
            let interval=a:0>0 ? a:1 : 5
            let funcArg=a:0>1 ? a:2 : ''
            if !exists('b:savedTime')
                let b:savedTime=localtime()
            elseif localtime()-b:savedTime>=interval
                silent! execute 'call SetFoldcolumn(' . funcArg . ')'
                let b:savedTime=localtime()
            endif
        endfunction

        " Show foldcolumn when exists folding
        function! SetFoldcolumn(...)
            let width=a:0>0 ? a:1 : 3
            let lineNum=1
            while lineNum <= line("$")
                if foldlevel(lineNum) != 0
                    silent! execute "set foldcolumn=" . width
                    return
                endif
                let lineNum=lineNum+1
            endwhile
            silent! execute "set foldcolumn=0"
        endfunction

        " Quickly set foldlevel
        function! SetFoldlevel(level)
            let _level=a:level+0
            if _level<0
                let _level=0
            endif
            silent! execute "set foldlevel=" . _level
            echo "foldlevel=" . _level
        endfunction

        " Toggle fold state between closed and opened
        function! ToggleFold()
            if foldlevel('.') == 0
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

        " Customize foldtext
        function! CustomFoldtext()
            let indent = repeat(' ', indent(v:foldstart))
            let startLine = getline(v:foldstart)
            let endLine = getline(v:foldend)
            let windowWidth = winwidth(0) - &foldcolumn - &numberwidth
            let foldSize = v:foldend - v:foldstart + 1
            let foldSizeStr = ' ' . foldSize . ' lines '
            let foldPercentage = printf("[%.1f", (foldSize * 1.0)/line('$') * 100) . "%] "
            let foldLevelStr = repeat('+--', v:foldlevel)
            " fold comments when set foldmarker = /\*,\*/
            if match(startLine, '^[ \t]*/\*\(\(\W\|_\)\(\*/\)\@!\)*[ \t]*$') == 0 && match(endLine, '^[ \t]*\(\(/\*\)\@<!\(\W\|_\)\)*\*/[ \t]*$') == 0
                let temp =matchstr(startLine, '^\([ \t]*/\*\)\ze\(\(\(\W\|_\)\(\*/\)\@!\)*\)')
                let startStr = substitute(temp, '^\t\+', indent, '')
                let text = startStr . ' ... */'
                let lineNum = v:foldstart + 1
                while lineNum < v:foldend
                    let curLine = getline(lineNum)
                    let comment = substitute(curLine, '^\%( \|\t\|\W\|_\)*\(.*\)[ \t]*$', '\1', '')
                    if comment != ''
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
                    let comment=substitute(comment, '.\{' . abs(expansionWidth) . '}$', '', '')
                    let text = startStr . ' ' . comment . ' */'
                    return text.foldSizeStr.foldPercentage.foldLevelStr
                endif
            endif
            " fold contents when set foldmarker = {,}
            if match(startLine, '{\+\d\=\ze[ \t]*$') > 0 && match(endLine, '^[ \t"]*\zs}\+\d\=') > 0
                let startBracket = matchstr(startLine, '{\+\d\=\ze[ \t]*$')
                let temp = substitute(startLine, '{\+\d\=[ \t]*$', '', '')
                let startStr = substitute(temp, '^\t\+', indent, '')
                let endBracket =matchstr(endLine, '^[ \t"]*\zs}\+\d\=')
                let endStr = substitute(endLine, '^[ \t"]*}\+\d\=', '', '')
                let text = startStr . startBracket . '...' . endBracket . endStr
                let expansionWidth = windowWidth - strwidth(text.foldSizeStr.foldPercentage.foldLevelStr)
                if expansionWidth > 0
                    let expansionStr = repeat(".", expansionWidth)
                    return text.expansionStr.foldSizeStr.foldPercentage.foldLevelStr
                else
                    if abs(expansionWidth) <= strwidth(endStr)
                        let endStr=substitute(endStr, '.\{' . abs(expansionWidth) . '}$', '', '')
                        let text = startStr . startBracket . '...' . endBracket . endStr
                        return text.foldSizeStr.foldPercentage.foldLevelStr
                    else
                        let startStr=substitute(startStr, '.\{' . (abs(expansionWidth)-strwidth(endStr)) . '}$', '', '')
                        let text = startStr . startBracket . '...' . endBracket
                        return text.foldSizeStr.foldPercentage.foldLevelStr
                    endif
                endif
            endif
        endfunction
        " }

        " Smart NERDTree bookmarks list
        function! SmartNERDTreeBookmark()
            " initialize
            if !filereadable(g:NERDTreeBookmarksFile)
                echohl WarningMsg | echo "g:NERDTreeBookmarksFile doesn't exist or can't read!" | echohl None
                return
            endif
            if filewritable(g:NERDTreeBookmarksFile) == 0
                echohl WarningMsg | echo "g:NERDTreeBookmarksFile doesn't exist or can't write!" | echohl None
                return
            endif
            let content = readfile(g:NERDTreeBookmarksFile)
            let desc = repeat(' ', 3) . '1-9 or CR = open, a = add, d = delete, D = delete all, e = edit, q or ESC = quit' . repeat(' ', 3)
            let desc = desc . "\n" . repeat('-', strlen(desc))
            " get the max len of bookmark name
            let nameMaxLen = 0
            for line in content
                if line != ''
                    let name = substitute(line, '^\(.\{-1,}\) .\+$', '\1', '')
                    let nameMaxLen = strlen(name) > nameMaxLen ? strlen(name) : nameMaxLen
                endif
            endfor
            " formatting
            let output = []
            for line in content
                if line != ''
                    let lineNum = !exists('lineNum') ? 1 : (lineNum+1)
                    let name = substitute(line, '^\(.\{-1,}\) .\+$', '\1', '')
                    let name = name . repeat(' ', nameMaxLen-strlen(name))
                    let path = substitute(line, '^.\{-1,} \(.\+\)$', '\1', '')
                    if lineNum <= 9
                        let newLine = lineNum. '. ' . name . ' => ' . path
                    else
                        let newLine = repeat(' ', 3) . name . ' => ' . path
                    endif
                    let output = empty('output') ? newLine : add(output, newLine)
                endif
            endfor
            " always switch to the [SmartNERDTreeBookmark] buffer if exists
            let s:bmBufferId = -1
            let s:bmBufferName = '[SmartNERDTreeBookmark]'
            if bufwinnr(s:bmBufferId) == -1
                silent! execute 'silent! keepalt botright ' . (len(output)>0 ? len(output)+2 : 3) . 'split'
                silent! execute ':e ' . s:bmBufferName
                let s:bmBufferId = bufnr('%') + 0
            else
                silent! execute bufwinnr(s:bmBufferId) . 'wincmd w'
            endif
            " set buffer environment
            setlocal buftype=nofile
            setlocal bufhidden=hide
            setlocal noswapfile
            setlocal nowrap
            setlocal nonumber
            setlocal norelativenumber
            setlocal nobuflisted
            setlocal statusline=%f%=Line:\ %l/%L[%p%%]\ Col:\ %c
            setlocal noreadonly
            setlocal modifiable
            " key mapping
            mapclear <buffer>
            nnoremap <buffer> <silent> <CR> :<C-U>call OperateBookmark()<CR>
            nnoremap <buffer> <silent> 1 :<C-U>call OperateBookmark(1)<CR>
            nnoremap <buffer> <silent> 2 :<C-U>call OperateBookmark(2)<CR>
            nnoremap <buffer> <silent> 3 :<C-U>call OperateBookmark(3)<CR>
            nnoremap <buffer> <silent> 4 :<C-U>call OperateBookmark(4)<CR>
            nnoremap <buffer> <silent> 5 :<C-U>call OperateBookmark(5)<CR>
            nnoremap <buffer> <silent> 6 :<C-U>call OperateBookmark(6)<CR>
            nnoremap <buffer> <silent> 7 :<C-U>call OperateBookmark(7)<CR>
            nnoremap <buffer> <silent> 8 :<C-U>call OperateBookmark(8)<CR>
            nnoremap <buffer> <silent> 9 :<C-U>call OperateBookmark(9)<CR>
            nnoremap <buffer> <silent> q :<C-U>call OperateBookmark('q')<CR>
            nnoremap <buffer> <silent> <ESC> :<C-U>call OperateBookmark('q')<CR>
            nnoremap <buffer> <silent> a :<C-U>call OperateBookmark('a')<CR>
            nnoremap <buffer> <silent> d :<C-U>call OperateBookmark('d')<CR>
            nnoremap <buffer> <silent> D :<C-U>call OperateBookmark('D')<CR>
            nnoremap <buffer> <silent> e :<C-U>call OperateBookmark('e')<CR>
            " show bookmarks
            silent! execute '%delete _'
            silent! put! = desc
            silent! put = output
            if getline('$') == ''
                silent! execute '$delete _'
            endif
            " let buffer can't be modified
            setlocal readonly
            setlocal nomodifiable
        endfunction

        function! OperateBookmark(...)
            " switch to [SmartNERDTreeBookmark] buffer
            if bufwinnr(s:bmBufferId) == -1
                echohl WarningMsg | echo 'Failed to switch to NERDTree bookmarks list buffer!' | echohl None
                return
            else
                silent! execute bufwinnr(s:bmBufferId) . 'wincmd w'
            endif
            if a:0 > 0
                if a:1 ==# 'q'
                    hide
                    return
                elseif a:1 ==# 'a'
                    let content = readfile(g:NERDTreeBookmarksFile)
                    let path = input('Directory to bookmark: ', '', 'dir')
                    if path != ''
                        let path = substitute(path, '\\ ', ' ', 'g')
                        let path = substitute(path, '\\$', '', '')
                    else
                        return
                    endif
                    let name = input('Bookmark as: ')
                    if name != ''
                        let name = substitute(name, ' ', '_', 'g')
                    else
                        return
                    endif
                    let line = name . ' '. path
                    let match = search(escape(path, ' \'), '', '')
                    if match > 2
                        call remove(content, match-3)
                        call insert(content, line, match-3)
                    else
                        call insert(content, line)
                    endif
                    call writefile(content, g:NERDTreeBookmarksFile)
                    hide
                    call SmartNERDTreeBookmark()
                    return
                elseif a:1 ==# 'd'
                    let content = readfile(g:NERDTreeBookmarksFile)
                    if line('.') > 2
                        call remove(content, line('.')-3)
                    else
                        return
                    endif
                    call writefile(content, g:NERDTreeBookmarksFile)
                    hide
                    call SmartNERDTreeBookmark()
                    return
                elseif a:1 ==# 'D'
                    let content = readfile(g:NERDTreeBookmarksFile)
                    call remove(content, 0, -1)
                    call writefile(content, g:NERDTreeBookmarksFile)
                    hide
                    call SmartNERDTreeBookmark()
                    return
                elseif a:1 ==# 'e'
                    let content = readfile(g:NERDTreeBookmarksFile)
                    if line('.') > 2
                        let name = substitute(getline('.'), '^\%([1-9]\.\)\= *\(.\{-1,}\) *=> .\+$', '\1', '')
                        let path = substitute(getline('.'), '^\%([1-9]\.\)\= *.\{-1,} *=> \(.\+\)$', '\1', '')
                        let newPath = input('Change directory to bookmark: ', escape(path, ' ') . '\', 'dir')
                        if newPath != ''
                            let newPath = substitute(newPath, '\\ ', ' ', 'g')
                            let newPath = substitute(newPath, '\\$', '', '')
                        else
                            let newPath = path
                        endif
                        let newName = input('Change bookmark as: ', name)
                        if newName != ''
                            let newName = substitute(newName, ' ', '_', 'g')
                        else
                            let newName = name
                        endif
                        let newLine = newName . ' '. newPath
                        call remove(content, line('.')-3)
                        call insert(content, newLine, line('.')-3)
                    else
                        return
                    endif
                    call writefile(content, g:NERDTreeBookmarksFile)
                    hide
                    call SmartNERDTreeBookmark()
                    return
                elseif matchstr(a:1, '[1-9]') != ''
                    let idx = a:1+2 > line('$') ? line('$') : a:1+2
                endif
            else
                let idx = line('.') > 2 ? line('.') : 3
            endif
            let path = substitute(getline(idx), '^\%([1-9]\.\)\= *.\{-1,} *=> \(.\+\)$', '\1', '')
            let path = escape(path, ' ') . '\'
            hide
            execute 'NERDTree ' . path
        endfunction

        " Restore screen size and position
        if has("gui_running")
            function! ScreenFilename()
                if has('win32') || has('win64')
                    return $HOME.'/.cache/.vimsize'
                endif
            endfunction

            function! ScreenRestore()
                let f = ScreenFilename()
                if has("gui_running") && g:screenSizeRestorePos && filereadable(f)
                    let vimInstance = (g:screenSizeByVimInstance==1?(v:servername):'GVIM')
                    for line in readfile(f)
                        let sizepos = split(line)
                        if len(sizepos) == 5 && sizepos[0] == vimInstance
                            silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
                            silent! execute "winpos ".sizepos[3]." ".sizepos[4]
                            return
                        endif
                    endfor
                endif
            endfunction

            function! ScreenSave()
                if has("gui_running") && g:screenSizeRestorePos
                    let vimInstance = (g:screenSizeByVimInstance==1?(v:servername):'GVIM')
                    let data = vimInstance . ' ' . &columns . ' ' . &lines . ' ' .
                                \ (getwinposx()<0?0:getwinposx()) . ' ' .
                                \ (getwinposy()<0?0:getwinposy())
                    let f = ScreenFilename()
                    if filereadable(f)
                        let lines = readfile(f)
                        call filter(lines, "v:val !~ '^" . vimInstance . "\\>'")
                        call add(lines, data)
                    else
                        let lines = [data]
                    endif
                    call writefile(lines, f)
                endif
            endfunction

            if !exists('g:screenSizeRestorePos')
                let g:screenSizeRestorePos = 1
            endif
            if !exists('g:screenSizeByVimInstance')
                let g:screenSizeByVimInstance = 1
            endif
            autocmd VimEnter * if g:screenSizeRestorePos == 1 | call ScreenRestore() | endif
            autocmd VimLeavePre * if g:screenSizeRestorePos == 1 | call ScreenSave() | endif
        endif
    " }}}2

" }}}1
