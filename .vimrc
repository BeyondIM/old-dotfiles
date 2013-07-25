" This is BeyondIM's vim config.

" Environment {{{1

    " Base {{{2
        " Enable no Vi compatible commands
        set nocompatible
        " Set viminfo path
        set viminfo+=n$HOME/.vimdb/.viminfo
        " Check system
        let s:isWin = has('win32') || has('win64')
        let s:isMac = has('unix') && substitute(system('uname'), '\n', '', '') =~# 'Darwin\|Mac' 
        let s:isLinux = has('unix') && substitute(system('uname'), '\n', '', '') ==# 'Linux' 
        " Remove all autocommands to avoid sourcing them twice
        autocmd!
    " }}}2

    " Windows Compatible {{{2
        if s:isWin
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }}}2

    " NeoBundle {{{2
        set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
        call neobundle#rc(expand('~/.vim/bundle/'))
        " Let NeoBundle manage NeoBundle
        NeoBundleFetch 'Shougo/neobundle.vim'
        " colorscheme
        NeoBundle 'nanotech/jellybeans.vim'
        NeoBundle 'BeyondIM/molokai'
        " enhancement
        NeoBundle 'kien/ctrlp.vim'
        NeoBundle 'tpope/vim-surround'
        NeoBundle 'tpope/vim-repeat'
        NeoBundle 'scrooloose/nerdtree'
        NeoBundle 'scrooloose/nerdcommenter'
        NeoBundle 'mileszs/ack.vim'
        NeoBundleLazy 'sjl/gundo.vim', {'autoload':{'commands':'GundoToggle'}} 
        " completion
        NeoBundle 'Valloric/YouCompleteMe'
        NeoBundle 'SirVer/ultisnips'
        " html
        NeoBundle 'othree/html5.vim'
        " css
        NeoBundle 'JulesWang/css.vim'
        " javascript
        NeoBundle 'pangloss/vim-javascript'
        " ruby
        NeoBundle 'vim-ruby/vim-ruby'
        NeoBundle 'tpope/vim-rails'
        " markdown
        NeoBundle 'tpope/vim-markdown'
        " gist
        NeoBundleLazy 'mattn/gist-vim', {'depends':'mattn/webapi-vim', 'autoload':{'commands':'Gist'}}
        " tags
        NeoBundle 'mozilla/doctorjs', {'rev': '1062dd3'}
        NeoBundle 'majutsushi/tagbar'
        " syntax check
        NeoBundle 'scrooloose/syntastic'
    " }}}2

    " Script {{{2
        set runtimepath+=$HOME/.vim/scripts/scriptbundle/
        " Set reverse proxy server or http, socks proxy if can't access vim official site
        " let g:vimSiteReverseProxyServer = 'http://vim.wendal.net'
        " let g:curlProxy = 'socks://127.0.0.1:8888'
        let g:curlProxy = 'http://127.0.0.1:8087'
        call scriptbundle#rc()
        " yankring
        Script '1234'
        " mark
        Script '2666'
        " matchit
        Script '39'
        " align
        Script '294'
        " wombat colorscheme
        Script '1778', {'subdir':'colors'}
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
        " Reload menu to show Chinese characters properly
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim        
        " Use Unix as the standard file type
        set fileformats=unix,dos,mac
        " Make a backup before overwriting a file
        set backup
        " Saves undo history when writing buffer to file and restores on buffer read
        if has('persistent_undo')
            set undofile
        endif
        " Use * register for copy-paste
        set clipboard=unnamed
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
        set statusline=[#%n]%(\ %{STLPath()}%)
        set statusline+=%(\ %{STLStatus()}%)
        set statusline+=%(\ %{STLFormat()}%)
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
        " Don't show the preview window
        set completeopt-=preview

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
            if s:isWin
                set guifont=Consolas:h12:cANSI
                set guifontwide=Yahei_Mono:h11
            elseif s:isMac
                set guifont=Consolas:h16
                set guifontwide=Heiti\ SC\ Light:h16
            endif
            " don't use ALT key to activate menu
            set winaltkeys=no
        endif
        " activate option key in macvim
        if has("gui_macvim")
            set macmeta
        end
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
        nnoremap <M-h> <C-W>h<C-W>_
        nnoremap <M-j> <C-W>j<C-W>_
        nnoremap <M-k> <C-W>k<C-W>_
        nnoremap <M-l> <C-W>l<C-W>_
        " Other windows keymapping
        nnoremap <M-o> <C-W>o
        nnoremap <M-q> <C-W>q

        " Keep search matches in the middle of the window.
        nnoremap n nzzzv
        nnoremap N Nzzzv

        " Fast saving
        nnoremap <Leader>w :<C-U>w!<CR>

        " Toggle search highlighting
        nnoremap <silent> <LocalLeader>/ :set hlsearch! hlsearch?<CR>

        " Toggle menubar
        nnoremap <silent> <LocalLeader>mb :<C-U>if &guioptions=~#'m'<BAR>set guioptions-=m<BAR>
                    \else<BAR>set guioptions+=m<BAR>
                    \endif<CR>

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
        nnoremap <silent> <C-F2> :set wrap! wrap?<CR>

        " Toggle listchars
        nnoremap <silent> <C-F3> :set list! list?<CR>
        imap <C-F3> <C-O><C-F3>
        xmap <C-F3> <Esc><C-F3>gv

        " Toggle ignore whitespace when diff
        nnoremap <LocalLeader>iw :<C-U>if &diffopt=~#'iwhite'<BAR>set diffopt-=iwhite<BAR>
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
    " }}}2

" }}}1


" Plugins {{{1

    " NERDTree {{{2
        let NERDTreeChDirMode = 2
        let s:normalExts = 'lib\|so\|obj\|pdf\|jpe\=g\|png\|gif\|zip\|rar\|7z\|z\|bz2\|tar\|gz\|tgz'
        let s:winExts = 'exe\|com\|dll\|ocx\|drv\|sys\|docx\=\|xlsx\=\|pptx\='
        let NERDTreeIgnore=['\c\.\(' . s:normalExts . '\|' .
                        \(s:isWin ? s:winExts : "") .
                        \'\)$']
        let NERDTreeBookmarksFile = $HOME.'/.vimdb/.NERDTreeBookmarks'
        let NERDTreeAutoDeleteBuffer = 1
        nnoremap <silent> <Leader>nn :<C-U>NERDTreeToggle<CR>
    " }}}2

    " CtrlP {{{2
        nnoremap <silent> <Leader>ff :<C-U>CtrlP<CR>
        nnoremap <silent> <Leader>fr :<C-U>CtrlPMRU<CR>
        nnoremap <silent> <Leader>b :<C-U>CtrlPBuffer<CR>
        let g:ctrlp_custom_ignore = {
                    \'dir' : '\c^\(' .
                        \(s:isWin ? 'c:\\Windows\\\|c:\\Users\\[^\\]\+\\' : "") .
                    \'\)',
                    \'file' : '\c\.\(' . s:normalExts . '\|' .
                        \(s:isWin ? s:winExts : "") .
                        \'\)$'
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

    " Vim-javascript {{{2
        let g:html_indent_inctags = "html,body,head,tbody"
        let g:html_indent_script1 = "inc"
        let g:html_indent_style1 = "inc"
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
        if s:isWin
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

    " YouCompleteMe {{{2
        let g:ycm_key_invoke_completion = '<C-l>'
    " }}}2

    " UltiSnips {{{2
        let g:UltiSnipsSnippetDirectories=["UltiSnips", ".mysnips"]
        let g:UltiSnipsExpandTrigger="<C-j>"
        let g:UltiSnipsJumpForwardTrigger="<C-j>"
        let g:UltiSnipsJumpBackwardTrigger="<C-k>"
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

    " Smart NERDTree bookmarks list {{{2
        function! s:SmartNERDTreeBookmark()
            " initialize
            call s:CheckFileReadable(g:NERDTreeBookmarksFile)
            if !exists('s:bmContent')
                let s:bmContent = readfile(g:NERDTreeBookmarksFile)
            endif
            let desc = repeat(' ', 3) .
                        \'1-9 or CR = open, a = add, d = delete, D = delete all, e = edit, q or ESC = quit' .
                        \repeat(' ', 3)
            let desc = desc . "\n" . repeat('-', strlen(desc))
            " get the max len of bookmark name
            let nameMaxLen = 0
            for line in s:bmContent
                if !empty(line)
                    let name = substitute(line, '^\(.\{-1,}\) .\+$', '\1', '')
                    let nameMaxLen = strlen(name) > nameMaxLen ? strlen(name) : nameMaxLen
                endif
            endfor
            " formatting
            let output = []
            for line in s:bmContent
                if !empty(line)
                    let lineNum = !exists('lineNum') ? 1 : (lineNum+1)
                    let name = substitute(line, '^\(.\{-1,}\) .\+$', '\1', '')
                    let name = name . repeat(' ', nameMaxLen-strlen(name))
                    let path = substitute(line, '^.\{-1,} \(.\+\)$', '\1', '')
                    if lineNum <= 9
                        let newLine = lineNum. '. ' . name . ' => ' . path
                    else
                        let newLine = repeat(' ', 3) . name . ' => ' . path
                    endif
                    call add(output, newLine)
                endif
            endfor
            " always switch to the [SmartNERDTreeBookmark] buffer if exists
            let s:bmBufferId = -1
            let s:bmBufferName = '[SmartNERDTreeBookmark]'
            if bufwinnr(s:bmBufferId) == -1
                silent! execute 'keepalt botright ' . (len(output)>0 ? len(output)+2 : 3) . 'split'
                silent! execute 'edit ' . s:bmBufferName
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
            nnoremap <buffer> <silent> <CR> :<C-U>call <SID>HandleBookmark()<CR>
            nnoremap <buffer> <silent> 1 :<C-U>call <SID>HandleBookmark(1)<CR>
            nnoremap <buffer> <silent> 2 :<C-U>call <SID>HandleBookmark(2)<CR>
            nnoremap <buffer> <silent> 3 :<C-U>call <SID>HandleBookmark(3)<CR>
            nnoremap <buffer> <silent> 4 :<C-U>call <SID>HandleBookmark(4)<CR>
            nnoremap <buffer> <silent> 5 :<C-U>call <SID>HandleBookmark(5)<CR>
            nnoremap <buffer> <silent> 6 :<C-U>call <SID>HandleBookmark(6)<CR>
            nnoremap <buffer> <silent> 7 :<C-U>call <SID>HandleBookmark(7)<CR>
            nnoremap <buffer> <silent> 8 :<C-U>call <SID>HandleBookmark(8)<CR>
            nnoremap <buffer> <silent> 9 :<C-U>call <SID>HandleBookmark(9)<CR>
            nnoremap <buffer> <silent> q :<C-U>call <SID>HandleBookmark('q')<CR>
            nnoremap <buffer> <silent> <ESC> :<C-U>call <SID>HandleBookmark('q')<CR>
            nnoremap <buffer> <silent> a :<C-U>call <SID>HandleBookmark('a')<CR>
            nnoremap <buffer> <silent> d :<C-U>call <SID>HandleBookmark('d')<CR>
            nnoremap <buffer> <silent> D :<C-U>call <SID>HandleBookmark('D')<CR>
            nnoremap <buffer> <silent> e :<C-U>call <SID>HandleBookmark('e')<CR>
            " show bookmarks
            silent! execute '%delete _'
            silent! put! = desc
            silent! put = output
            if empty(getline('$'))
                silent! execute '$delete _'
            endif
            " let buffer can't be modified
            setlocal readonly
            setlocal nomodifiable
        endfunction

        function! s:HandleBookmark(...)
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
                    let path = input('Directory to bookmark: ', '', 'dir')
                    if !empty(path)
                        let path = substitute(expand(path, 1), '\\ ', ' ', 'g')
                        let path = substitute(path, '[\\/]$', '', '')
                    else
                        return
                    endif
                    let name = input('Bookmark as: ')
                    if !empty(name)
                        let name = substitute(name, ' ', '_', 'g')
                    else
                        return
                    endif
                    let line = name . ' '. path
                    let match = search(escape(path, '\ '), '', '')
                    if match > 2
                        call remove(s:bmContent, match-3)
                        call insert(s:bmContent, line, match-3)
                    else
                        call insert(s:bmContent, line)
                    endif
                    hide
                    call s:SmartNERDTreeBookmark()
                    return
                elseif a:1 ==# 'd'
                    if line('.') > 2
                        call remove(s:bmContent, line('.')-3)
                    else
                        return
                    endif
                    hide
                    call s:SmartNERDTreeBookmark()
                    return
                elseif a:1 ==# 'D'
                    call remove(s:bmContent, 0, -1)
                    hide
                    call s:SmartNERDTreeBookmark()
                    return
                elseif a:1 ==# 'e'
                    if line('.') > 2
                        let name = substitute(getline('.'), '^\%([1-9]\.\)\= *\(.\{-1,}\) *=> .\+$', '\1', '')
                        let path = substitute(getline('.'), '^\%([1-9]\.\)\= *.\{-1,} *=> \(.\+\)$', '\1', '')
                        let newPath = input('Change directory to bookmark: ', escape(path, ' ') .
                                    \(s:isWin ? '\' : '/'), 'dir')
                        if !empty(newPath)
                            let newPath = substitute(expand(newPath, 1), '\\ ', ' ', 'g')
                            let newPath = substitute(newPath, '[\\/]$', '', '')
                        else
                            let newPath = path
                        endif
                        let newName = input('Change bookmark as: ', name)
                        if !empty(newName)
                            let newName = substitute(newName, ' ', '_', 'g')
                        else
                            let newName = name
                        endif
                        let newLine = newName . ' '. newPath
                        call remove(s:bmContent, line('.')-3)
                        call insert(s:bmContent, newLine, line('.')-3)
                    else
                        return
                    endif
                    hide
                    call s:SmartNERDTreeBookmark()
                    return
                elseif !empty(matchstr(a:1, '[1-9]'))
                    let idx = a:1+2 > line('$') ? line('$') : a:1+2
                endif
            else
                let idx = line('.') > 2 ? line('.') : 3
            endif
            let path = substitute(getline(idx), '^\%([1-9]\.\)\= *.\{-1,} *=> \(.\+\)$', '\1', '')
            let path = escape(path, ' ') . (s:isWin ? '\' : '/')
            hide
            execute 'NERDTree ' . path
        endfunction

        function! s:WriteBookmraksFile()
            call s:CheckFileReadable(g:NERDTreeBookmarksFile)
            call s:CheckFileWritable(g:NERDTreeBookmarksFile)
            if !exists('s:bmContent')
                let s:bmContent = readfile(g:NERDTreeBookmarksFile)
            endif
            call writefile(s:bmContent, g:NERDTreeBookmarksFile)
        endfunction

        " Save bookmark when leaving
        autocmd VimLeavePre * call s:WriteBookmraksFile()

        nnoremap <silent> <Leader>nb :<C-U>call <SID>SmartNERDTreeBookmark()<CR>
    " }}}2

    " Toggle color schemes {{{2
        " set default color scheme
        let s:fallbackColor = 'default'
        " add all favorite color schemes to toggle
        let s:darkColors = ['jellybeans', 'molokai', 'wombat']
        let s:lightColors = ['mayansmoke']

        function! s:SetColor(color)
            if index(s:darkColors, a:color) != -1
                let bg = 'dark'
            elseif index(s:lightColors, a:color) != -1
                let bg = 'light'
            else
                silent! execute 'colorscheme '.s:fallbackColor
                let &background = 'light'
                return
            endif
            call s:HandleColor(a:color, bg)
        endfunction

        function! s:SetDarkColor(handle)
            if a:handle == '+'
                if exists('g:colors_name') && index(s:darkColors, g:colors_name) != -1
                    if &background == 'light'
                        let curColor = g:colors_name
                    else
                        let idx = index(s:darkColors, g:colors_name)
                        let curColor = idx<(len(s:darkColors)-1) ? s:darkColors[idx+1] : s:darkColors[0]
                    endif
                else
                    let curColor = exists('s:lastDarkColor') ? s:lastDarkColor : s:darkColors[0]
                endif
            elseif a:handle == '-'
                if exists('g:colors_name') && index(s:darkColors, g:colors_name) != -1
                    if &background == 'light'
                        let curColor = g:colors_name
                    else
                        let idx = index(s:darkColors, g:colors_name)
                        let curColor = (idx>0) ? s:darkColors[idx-1] : s:darkColors[-1]
                    endif
                else
                    let curColor = exists('s:lastDarkColor') ? s:lastDarkColor : s:darkColors[-1]
                endif
            endif
            call s:HandleColor(curColor, 'dark')
            if exists('g:colors_name')
                redraw
                echo 'Current color scheme: '.g:colors_name
            endif
        endfunction

        function! s:SetLightColor(handle)
            if a:handle == '+'
                if exists('g:colors_name') && index(s:lightColors, g:colors_name) != -1
                    if &background == 'dark'
                        let curColor = g:colors_name
                    else
                        let idx = index(s:lightColors, g:colors_name)
                        let curColor = idx<(len(s:lightColors)-1) ? s:lightColors[idx+1] : s:lightColors[0]
                    endif
                else
                    let curColor = exists('s:lastLightColor') ? s:lastLightColor : s:lightColors[0]
                endif
            elseif a:handle == '-'
                if exists('g:colors_name') && index(s:lightColors, g:colors_name) != -1
                    if &background == 'dark'
                        let curColor = g:colors_name
                    else
                        let idx = index(s:lightColors, g:colors_name)
                        let curColor = (idx>0) ? s:lightColors[idx-1] : s:lightColors[-1]
                    endif
                else
                    let curColor = exists('s:lastLightColor') ? s:lastLightColor : s:lightColors[-1]
                endif
            endif
            call s:HandleColor(curColor, 'light')
            if exists('g:colors_name')
                redraw
                echo 'Current color scheme: '.g:colors_name
            endif
        endfunction

        function! s:IsValidColor(color)
            let colorsPathList = globpath(&runtimepath, 'colors/*.vim', 1)
            let colorsList = map(split(colorsPathList, '\n'), "fnamemodify(v:val, ':t:r')")
            if index(colorsList, a:color) != -1
                return 1
            else
                return
            endif
        endfunction

        function! s:HandleColor(color,bg)
            if !s:IsValidColor(a:color)
                echohl ErrorMsg | echo 'Color scheme: '.a:color.' is invalid.' | echohl None
                return
            else
                silent! execute 'colorscheme '.a:color
            endif
            if a:bg == 'dark'
                let &background = 'dark'
                let s:lastDarkColor = a:color
            elseif a:bg == 'light'
                let &background = 'light'
                let s:lastLightColor = a:color
            endif
        endfunction

        nnoremap <silent> <C-F10> :<C-U>call <SID>SetDarkColor('+')<CR>
        nnoremap <silent> <M-F10> :<C-U>call <SID>SetDarkColor('-')<CR>
        nnoremap <silent> <C-F11> :<C-U>call <SID>SetLightColor('+')<CR>
        nnoremap <silent> <M-F11> :<C-U>call <SID>SetLightColor('-')<CR>
    " }}}2

    " Adjust window size and opacity {{{2
        function! s:AdjustFrameAlpha(handle)
            if !has('gui_running')
                return
            endif
            if !exists('s:frameParams')
                call s:InitFrameParams()
            endif
            let elem = split(s:frameParams)
            if elem[0] == v:servername
                let alpha = elem[2]+0
                if a:handle == '+'
                    if s:isWin && alpha < 255
                        let alpha = alpha+1
                    elseif s:isMac && alpha > 0
                        let alpha = alpha-1
                    endif
                endif
                if a:handle == '-'
                    if s:isWin && alpha > 0
                        let alpha = alpha-1
                    elseif s:isMac && alpha < 100
                        let alpha = alpha+1
                    endif
                endif
                let s:frameParams = elem[0] . ' ' . elem[1] . ' ' . alpha . ' ' . &lines . ' ' . &columns . ' ' .
                            \(getwinposx()<0 ? 0 : getwinposx()) . ' ' .
                            \(getwinposy()<0 ? 0 : getwinposy()) . ' ' .
                            \(exists('g:colors_name') ? g:colors_name : s:fallbackColor)
                call s:RestoreFrameParams()
            endif
        endfunction

        function! s:AdjustFrameSize()
            if !has('gui_running')
                return
            endif
            if !exists('s:frameParams')
                call s:InitFrameParams()
            endif
            let elem = split(s:frameParams)
            if elem[0] == v:servername
                let isMaximized = elem[1]+0 ? 0 : 1
                let s:frameParams = elem[0] . ' ' . isMaximized . ' ' . elem[2] . ' ' . &lines . ' ' . &columns . ' ' .
                            \(getwinposx()<0 ? 0 : getwinposx()) . ' ' .
                            \(getwinposy()<0 ? 0 : getwinposy()) . ' ' .
                            \(exists('g:colors_name') ? g:colors_name : s:fallbackColor)
                call s:RestoreFrameParams()
            endif
        endfunction

        function! s:InitFrameParams()
            let s:frameParams = v:servername . ' 0 ' . (s:isWin ? '255 ' : '0 ') . &lines . ' ' . &columns . ' ' .
                        \(getwinposx()<0 ? 0 : getwinposx()) . ' ' .
                        \(getwinposy()<0 ? 0 : getwinposy()) . ' ' .
                        \(exists('g:colors_name') ? g:colors_name : s:fallbackColor)
        endfunction

        function! s:RestoreFrameParams()
            let elem = split(s:frameParams)
            if elem[0] == v:servername
                if elem[1]+0
                    if s:isWin
                        call libcallnr("vimtweak.dll", "EnableMaximize", 1)
                        call libcallnr("vimtweak.dll", "EnableCaption", 0)
                    elseif s:isMac
                        let &g:fullscreen = 1
                    endif
                else
                    silent! execute 'set lines=' . elem[3] . ' columns=' . elem[4]
                    silent! execute 'winpos ' . elem[5] . ' ' .  elem[6]
                    if s:isWin
                        call libcallnr("vimtweak.dll", "EnableCaption", 1)
                        call libcallnr("vimtweak.dll", "EnableMaximize", 0)
                    elseif s:isMac
                        let &g:fullscreen = 0
                    endif
                endif
                if s:isWin
                    call libcallnr("vimtweak.dll", "SetAlpha", elem[2]+0)
                elseif s:isMac
                    let &g:transparency = elem[2]+0
                endif
                call s:SetColor(elem[7])
            endif
        endfunction

        function! s:WriteFrameParams()
            call s:CheckFileReadable($HOME.'/.vimdb/.vimsize')
            call s:CheckFileWritable($HOME.'/.vimdb/.vimsize')
            let elem = split(s:frameParams)
            if elem[0] == v:servername
                let newFrameParams = elem[0] . ' ' . elem[1] . ' ' . elem[2] . ' ' . &lines . ' ' . &columns . ' ' .
                            \(getwinposx()<0 ? 0 : getwinposx()) . ' ' .
                            \(getwinposy()<0 ? 0 : getwinposy()) . ' ' .
                            \(exists('g:colors_name') ? g:colors_name : s:fallbackColor)
            endif
            let content = readfile($HOME.'/.vimdb/.vimsize')
            let content = filter(content, "v:val !~# '^".v:servername." '")
            call add(content, newFrameParams)
            call writefile(content, $HOME.'/.vimdb/.vimsize')
        endfunction

        function! s:ReadFrameParams()
            call s:CheckFileReadable($HOME.'/.vimdb/.vimsize')
            let content = readfile($HOME.'/.vimdb/.vimsize')
            let content = filter(content, "v:val =~# '^".v:servername." '")
            if len(content) > 0
                let s:frameParams = content[-1]
            else
                call s:InitFrameParams()
            endif
            call s:RestoreFrameParams()
        endfunction

        if s:isWin && !empty(glob($VIMRUNTIME.'/vimtweak.dll')) || s:isMac
            nnoremap <silent> <C-F12> :<C-U>call <SID>AdjustFrameSize()<CR>
            nnoremap <silent> <C-Left> :<C-U>call <SID>AdjustFrameAlpha('-')<CR>
            nnoremap <silent> <C-Right> :<C-U>call <SID>AdjustFrameAlpha('+')<CR>

            autocmd VimEnter * call s:ReadFrameParams()
            autocmd VimLeavePre * call s:WriteFrameParams()
        endif
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
                echo 'No matching buffer for Show the line and column number of the cursor position, separated by a' . a:buffer
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
        nnoremap <silent> <Left> <<
        nnoremap <silent> <Right> >>
        nnoremap <silent> <Up> <Esc>:call <SID>AddEmptyLine('-')<CR>
        nnoremap <silent> <Down>  <Esc>:call <SID>AddEmptyLine('+')<CR>
        nnoremap <silent> <C-Up> <Esc>:call <SID>DelEmptyLine('-')<CR>
        nnoremap <silent> <C-Down> <Esc>:call <SID>DelEmptyLine('+')<CR>

        " visual mode
        vnoremap <silent> <Left> <gv
        vnoremap <silent> <Right> >gv
        vnoremap <silent> <Up> <Esc>:call <SID>AddEmptyLine('-')<CR>gv
        vnoremap <silent> <Down>  <Esc>:call <SID>AddEmptyLine('+')<CR>gv
        vnoremap <silent> <C-Up> <Esc>:call <SID>DelEmptyLine('-')<CR>gv
        vnoremap <silent> <C-Down> <Esc>:call <SID>DelEmptyLine('+')<CR>gv

        " insert mode
        inoremap <silent> <Left> <C-D>
        inoremap <silent> <Right> <C-T>
        inoremap <silent> <Up> <Esc>:call <SID>AddEmptyLine('-')<CR>a
        inoremap <silent> <Down> <Esc>:call <SID>AddEmptyLine('+')<CR>a
        inoremap <silent> <C-Up> <Esc>:call <SID>DelEmptyLine('-')<CR>a
        inoremap <silent> <C-Down> <Esc>:call <SID>DelEmptyLine('+')<CR>a
    " }}}2

    " Preview markdown files {{{2
        function! s:PreviewMarkdown()
            if !executable('pandoc')
                echohl ErrorMsg | echo 'Please install pandoc first.' | echohl None
                return
            endif
            if s:isWin
                let BROWSER_COMMAND = 'cmd.exe /c start ""'
            elseif s:isLinux
                let BROWSER_COMMAND = 'xdg-open'
            elseif s:isMac
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
                                \(s:isWin ? '\\\\' : '/') . 
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
        function! STLPath()
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

        function! STLStatus()
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

        function! STLFormat()
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
