" vim: set shiftwidth=4 tabstop=4 softtabstop=4 expandtab foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
" Environment {{{1

    " Base {{{2
        set nocompatible
        " Remove all autocommands to avoid sourcing them twice
        autocmd!
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
        " comment
        Bundle 'scrooloose/nerdcommenter'
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
        autocmd FileType css,php,javascript autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    " }}}2

" }}}1


" Plugins {{{1

    " Numbers {{{2
        nnoremap <F3> :NumbersToggle<CR>
    " }}}2

    " CtrlP {{{2
        nnoremap <silent> <leader>ff :CtrlP<CR>
        nnoremap <silent> <leader>b :CtrlPBuffer<CR>
        nnoremap <silent> <leader>fa :CtrlPBookmarkDirAdd<CR>
        nnoremap <silent> <leader>fd :CtrlPBookmarkDir<CR>
        let g:ctrlp_custom_ignore = {
                    \ 'dir' : '^\(c:\\Windows\|c:\\Users\\Administrator\)',
                    \ 'file' : '\.\(exe\|com\|so\|dll\|sys\|ocx\|dat\|drv\|rom\|ax\|db\|pdf\|jpe\=g\|png\|gif\|docx\=\|xlsx\=\|pptx\=\)$',
                    \ }
        let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
    " }}}2

    " YankRing {{{2
        nnoremap <silent> <Leader>y :YRGetElem<CR>
        function! YRRunAfterMaps()
            nnoremap <silent> Y :<C-U>YRYankCount 'y$'<CR>
        endfunction
    " }}}2

    " PIV {{{2
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
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
        inoremap <expr><C-g>    neocomplcache#undo_completion()
        inoremap <expr><C-l>    neocomplcache#complete_common_string()
        inoremap <expr><C-h>    neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
        inoremap <expr><C-TAB>  pumvisible() ? neocomplcache#close_popup() . "\<TAB>" : "\<TAB>"

        inoremap <expr><CR> neosnippet#expandable() ? neosnippet#expand_impl() : pumvisible() ? neocomplcache#close_popup() : "\<CR>"
        inoremap <expr><S-CR> neosnippet#expandable() ? neosnippet#expand_impl() : pumvisible() ? neocomplcache#close_popup() . "\<CR>" : "\<CR>"
        inoremap <expr><C-CR> pumvisible() ? neocomplcache#close_popup() . "\<CR>" : "\<CR>"
        snoremap <expr><CR> neosnippet#expandable() ? neosnippet#expand_impl() : "\<CR>"

        inoremap <silent> <expr><C-k> neosnippet#jumpable() ? neosnippet#jump_impl() : "\<ESC>"
        snoremap <silent> <expr><C-k> neosnippet#jumpable() ? neosnippet#jump_impl() : "\<ESC>"

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
        nnoremap <silent> <leader>tt :TagbarToggle<CR>
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

        " Fast saving
        nnoremap <leader>w :w!<CR>
        " Toggle search highlighting
        nnoremap <silent> <leader>/ :set hlsearch! hlsearch?<CR>
        " Quickly set foldlevel when zr/zm seems slowly
        nnoremap <silent> <Leader>fl :call SetFoldlevel(input("Enter foldlevel: "))<CR>
        " Toggle folds
        nnoremap <space> :call ToggleFold()<CR>
        " Toggle wrap lines
        nnoremap <silent> <F4> :set wrap! wrap?<CR>
        " Toggle listchars
        nnoremap <silent> <F2> :set list! list?<CR>
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
        " Automatically change the current directory 
        autocmd BufEnter * silent! lcd %:p:h

        " Return to last edit position when opening files 
        autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
        
        " Don't screw up folds when inserting text that might affect them, until leaving insert mode
        autocmd InsertEnter * if !exists('b:last_fdm') | let b:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
        autocmd InsertLeave,WinLeave * if exists('b:last_fdm') | let &l:foldmethod=b:last_fdm | unlet b:last_fdm | endif
        
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
            let funcarg=a:0>1 ? a:2 : ''
            if !exists('b:savedtime')
                let b:savedtime=localtime()
            elseif localtime()-b:savedtime>=interval
                silent! execute 'call SetFoldcolumn(' . funcarg . ')'
                let b:savedtime=localtime()
            endif
        endfunction

        " Show foldcolumn when exists folding
        function! SetFoldcolumn(...) 
            let width=a:0>0 ? a:1 : 3
            let lnum=1
            while lnum <= line("$")
                if foldlevel(lnum) != 0
                    silent! execute "set foldcolumn=" . width
                    return
                endif
                let lnum=lnum+1
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
            let startline = getline(v:foldstart)
            let endline = getline(v:foldend)
            let windowwidth = winwidth(0) - &foldcolumn - &numberwidth
            let foldsize = v:foldend - v:foldstart + 1
            let foldsizestr = ' ' . foldsize . ' lines '
            let foldpercentage = printf("[%.1f", (foldsize * 1.0)/line('$') * 100) . "%] "
            let foldlevelstr = repeat('+--', v:foldlevel)
            if match(startline, '^[ \t]*/\*\(\(\W\|_\)\(\*/\)\@!\)*[ \t]*$') == 0 && match(endline, '^[ \t]*\(\(/\*\)\@<!\(\W\|_\)\)*\*/[ \t]*$') == 0
                let temp =matchstr(startline, '^\([ \t]*/\*\)\ze\(\(\(\W\|_\)\(\*/\)\@!\)*\)')
                let startstr = substitute(temp, '^\t\+', indent, '')
                let text = startstr . ' ... */'
                let linenum = v:foldstart + 1
                while linenum < v:foldend
                    let curline = getline(linenum)
                    let comment = substitute(curline, '^\%( \|\t\|\W\|_\)*\(.*\)[ \t]*$', '\1', '')
                    if comment != ''
                        let text = startstr . ' ' . comment . ' */'
                        break
                    endif
                    let linenum = linenum + 1
                endwhile
                let expansionwidth = windowwidth - strwidth(text.foldsizestr.foldpercentage.foldlevelstr)
                if expansionwidth > 0
                    let expansionstr = repeat(".", expansionwidth)
                    return text.expansionstr.foldsizestr.foldpercentage.foldlevelstr
                else
                    let comment=substitute(comment, '.\{' . abs(expansionwidth) . '}$', '', '')
                    let text = startstr . ' ' . comment . ' */'
                    return text.foldsizestr.foldpercentage.foldlevelstr
                endif
            endif
            if match(startline, '{\+\d\=\ze[ \t]*$') > 0 && match(endline, '^[ \t"]*\zs}\+\d\=') > 0
                let startbracket = matchstr(startline, '{\+\d\=\ze[ \t]*$')
                let temp = substitute(startline, '{\+\d\=[ \t]*$', '', '')
                let startstr = substitute(temp, '^\t\+', indent, '')
                let endbracket =matchstr(endline, '^[ \t"]*\zs}\+\d\=')
                let endstr = substitute(endline, '^[ \t"]*}\+\d\=', '', '')
                let text = startstr . startbracket . '...' . endbracket . endstr
                let expansionwidth = windowwidth - strwidth(text.foldsizestr.foldpercentage.foldlevelstr)
                if expansionwidth > 0
                    let expansionstr = repeat(".", expansionwidth)
                    return text.expansionstr.foldsizestr.foldpercentage.foldlevelstr
                else
                    if abs(expansionwidth) <= strwidth(endstr)
                        let endstr=substitute(endstr, '.\{' . abs(expansionwidth) . '}$', '', '')
                        let text = startstr . startbracket . '...' . endbracket . endstr
                        return text.foldsizestr.foldpercentage.foldlevelstr
                    else
                        let startstr=substitute(startstr, '.\{' . (abs(expansionwidth)-strwidth(endstr)) . '}$', '', '')
                        let text = startstr . startbracket . '...' . endbracket
                        return text.foldsizestr.foldpercentage.foldlevelstr
                    endif
                endif
            endif
        endfunction
        " }

        " Restore screen size and position
        if has("gui_running")
            function! ScreenFilename()
                if has('win32') || has('win64')
                    return $HOME.'\_vimsize'
                endif
            endfunction

            function! ScreenRestore()
                let f = ScreenFilename()
                if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
                    let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
                    for line in readfile(f)
                        let sizepos = split(line)
                        if len(sizepos) == 5 && sizepos[0] == vim_instance
                            silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
                            silent! execute "winpos ".sizepos[3]." ".sizepos[4]
                            return
                        endif
                    endfor
                endif
            endfunction

            function! ScreenSave()
                if has("gui_running") && g:screen_size_restore_pos
                    let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
                    let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
                                \ (getwinposx()<0?0:getwinposx()) . ' ' .
                                \ (getwinposy()<0?0:getwinposy())
                    let f = ScreenFilename()
                    if filereadable(f)
                        let lines = readfile(f)
                        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
                        call add(lines, data)
                    else
                        let lines = [data]
                    endif
                    call writefile(lines, f)
                endif
            endfunction

            if !exists('g:screen_size_restore_pos')
                let g:screen_size_restore_pos = 1
            endif
            if !exists('g:screen_size_by_vim_instance')
                let g:screen_size_by_vim_instance = 1
            endif
            autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
            autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
        endif
    " }}}2

" }}}1
