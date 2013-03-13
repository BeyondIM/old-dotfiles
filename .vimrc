" vim: set shiftwidth=4 tabstop=4 softtabstop=4 expandtab foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
" Environment {{{1

    " Base {{{2
        " Important
        set nocompatible
        " Set viminfo path
        set viminfo+=n$HOME/.cache/.viminfo
        " Remove all autocommands to avoid sourcing them twice
        autocmd!
    " }}}2

    " Windows Compatible {{{2
        if has('win32') || has('win64')
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }}}2

    " Neobundle {{{2
        set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
        call neobundle#rc(expand('$HOME/.vim/bundle/'))
        " Let NeoBundle manage NeoBundle
        NeoBundleFetch 'Shougo/neobundle.vim'
        " colorscheme
        NeoBundle 'nanotech/jellybeans.vim'
        " enhancement
        NeoBundle 'kien/ctrlp.vim'
        NeoBundleLazy 'godlygeek/tabular', {'autoload':{'commands':'Tabularize'}}
        NeoBundle 'tpope/vim-surround'
        NeoBundle 'tpope/vim-repeat'
        NeoBundle 'vim-scripts/YankRing.vim'
        NeoBundle 'scrooloose/nerdtree'
        NeoBundle 'scrooloose/nerdcommenter'
        NeoBundleLazy 'sjl/gundo.vim', {'autoload':{'commands':'GundoToggle'}}
        NeoBundle 'Lokaltog/powerline', {'rtp':$HOME.'/.vim/bundle/powerline/powerline/bindings/vim'}
        NeoBundle 'Lokaltog/vim-easymotion'
        " completion
        NeoBundle 'SirVer/ultisnips'
        NeoBundle 'Valloric/YouCompleteMe'
        " html
        NeoBundleLazy 'othree/html5.vim', {'autoload':{'filetypes':'html'}}
        NeoBundle 'Valloric/MatchTagAlways'
        " css
        NeoBundleLazy 'lepture/vim-css', {'autoload':{'filetypes':'css'}}
        NeoBundleLazy 'ap/vim-css-color', {'autoload':{'filetypes':'css'}}
        " php
        NeoBundleLazy 'spf13/PIV', {'autoload':{'filetypes':'php'}}
        " javascript
        NeoBundleLazy 'pangloss/vim-javascript', {'autoload':{'filetypes':'javascript'}}
        " markdown
        NeoBundleLazy 'tpope/vim-markdown', {'autoload':{'filetypes':'markdown'}}
        NeoBundleLazy 'waylan/vim-markdown-extra-preview', {'autoload':{'commands':['Me','Mer']}}
        " gist
        NeoBundleLazy 'mattn/gist-vim', {'depends':'mattn/webapi-vim', 'autoload':{'commands':'Gist'}}
        " tags
        NeoBundleLazy 'mozilla/doctorjs', '1062dd3', 'same', {'autoload':{'filetypes':'javascript'}}
        NeoBundleLazy 'techlivezheng/phpctags', {'autoload':{'filetypes':'php'}}
        NeoBundleLazy 'techlivezheng/tagbar-phpctags', {'autoload':{'filetypes':'php'}}
        NeoBundle 'majutsushi/tagbar'
        " syntax check
        NeoBundle 'scrooloose/syntastic'
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
        " Set zh_CN.utf-8 as the standard language
        language messages zh_CN.utf-8
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
        let mapleader=","
        let g:mapleader=","
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
        " Always show statusline
        set laststatus=2
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

        " Set extra options when running in GUI mode
        if has("gui_running")
            " use console dialogs
            set guioptions+=c
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
            set guifont=Consolas_for_Powerline:h12:cANSI
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
        " Highlight current line when in insert mode
        autocmd InsertLeave * set nocursorline
        autocmd InsertEnter * set cursorline

        " Fast source $MYVIMRC
        autocmd BufWritePost .vimrc nested source $MYVIMRC

        " Return to last edit position when opening files
        autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

        " Set working directory to the current file
        "autocmd BufEnter * if expand("%:p:h") !~ '^C:\\Windows\\system32' | silent! lcd %:p:h | endif

        " OmniComplete
        autocmd filetype * if exists('+omnifunc') && &omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif

        " Customize indent style
        autocmd FileType javascript,html,xhtml,css setlocal tabstop=2 shiftwidth=2 softtabstop=2

        " Resize splits when the window is resized
        autocmd VimResized * execute "normal! \<c-w>="

        " Diff orig file
        if !exists(":DiffOrig")
            command DiffOrig vnew | set buftype=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
        endif

        " Append date/time
        command! -nargs=0 AppendNow  :execute "normal a".strftime("%c")
        command! -nargs=0 AppendDate :execute "normal a".strftime("%Y-%m-%d")
        command! -nargs=0 AppendTime :execute "normal a".strftime("%H:%M")
        command! -nargs=0 AppendDateTime :execute "normal a".strftime("%Y-%m-%d %H:%M")
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
        nnoremap <leader>w :<C-U>w!<CR>

        " Toggle search highlighting
        nnoremap <silent> <leader>/ :set hlsearch! hlsearch?<CR>

        " Toggle menubar
        nnoremap <silent> <leader><leader>m :<C-U>if &guioptions=~#'m'<BAR>set guioptions-=m<BAR>else<BAR>set guioptions+=m<BAR>endif<CR>

        " Invert 'foldenable'
        nnoremap <leader>fe :set foldenable! foldenable?<CR>

        " Quickly set foldlevel
        nnoremap <leader>f0 :set foldlevel=0<CR>
        nnoremap <leader>f1 :set foldlevel=1<CR>
        nnoremap <leader>f2 :set foldlevel=2<CR>
        nnoremap <leader>f3 :set foldlevel=3<CR>
        nnoremap <leader>f4 :set foldlevel=4<CR>
        nnoremap <leader>f5 :set foldlevel=5<CR>
        nnoremap <leader>f6 :set foldlevel=6<CR>
        nnoremap <leader>f7 :set foldlevel=7<CR>
        nnoremap <leader>f8 :set foldlevel=8<CR>
        nnoremap <leader>f9 :set foldlevel=9<CR>

        " Toggle wrap lines
        nnoremap <silent> <F2> :set wrap! wrap?<CR>

        " Toggle listchars
        nnoremap <silent> <F3> :set list! list?<CR>
        imap <F2> <C-O><F2>
        xmap <F2> <Esc><F2>gv

        " Toggle ignore whitespace when diff
        nnoremap <leader>dw :<C-U>if &diffopt=~#'iwhite'<BAR>set diffopt-=iwhite<BAR>else<BAR>set diffopt+=iwhite<BAR>endif<BAR>set diffopt?<CR>

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
        let NERDTreeIgnore=['\~$', '\c\.\(exe\|com\|so\|dll\|sys\|ocx\|dat\|drv\|rom\|ax\|db\|pdf\|jpe\=g\|png\|gif\|docx\=\|xlsx\=\|pptx\=\|dwg\|zip\|rar\|7z\)$']
        let NERDTreeBookmarksFile = $HOME.'/.cache/.NERDTreeBookmarks'
        let NERDTreeAutoDeleteBuffer = 1
        nnoremap <silent> <Leader>nn :<C-U>NERDTreeToggle<CR>
    " }}}2

    " CtrlP {{{2
        nnoremap <silent> <leader>ff :<C-U>CtrlP<CR>
        nnoremap <silent> <Leader>fr :<C-U>CtrlPMRU<CR>
        nnoremap <silent> <leader>bb :<C-U>CtrlPBuffer<CR>
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

    " Vim-javascript {{{2
        let g:html_indent_inctags = "html,body,head,tbody"
        let g:html_indent_script1 = "inc"
        let g:html_indent_style1 = "inc"
    " }}}2

    " Gundo {{{2
        nnoremap <leader>u :GundoToggle<CR>
        let g:gundo_width = 30
        let g:gundo_preview_bottom = 1
        let g:gundo_tree_statusline = 'Gundo'
        let g:gundo_preview_statusline = 'Gundo Preview'
    " }}}2

    " Tagbar {{{2
        nnoremap <silent> <leader>tt :TagbarToggle<CR>
        let g:tagbar_ctags_bin = $HOME.'/bin/ctags58/ctags.exe'
        let g:tagbar_systemenc = 'cp936'
        let g:tagbar_autofocus = 1
        let g:tagbar_type_javascript = { 'ctagsbin' : $HOME.'/bin/jsctags.bat' }
        let g:tagbar_phpctags_bin = $HOME.'/bin/phpctags.bat'
        let g:tagbar_type_markdown = {
                    \ 'ctagstype' : 'markdown',
                    \ 'kinds' : [
                    \ 'h:Heading_L1',
                    \ 'i:Heading_L2',
                    \ 'k:Heading_L3'
                    \ ]
                    \ }
    " }}}2

    " Syntastic {{{2
        let g:syntastic_error_symbol='ХХ'
        let g:syntastic_style_error_symbol='SХ'
        let g:syntastic_warning_symbol='!!'
        let g:syntastic_style_warning_symbol='S!'
        let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
        let g:syntastic_php_phpcs_args='--tab-width=4 --report=csv'
        let g:syntastic_javascript_checkers=['jslint']
    " }}}2

    " Ultisnips {{{2
        let g:UltiSnipsExpandTrigger='<C-space>'
    "}}}2

    " Youcompleteme {{{2
        let g:ycm_key_invoke_completion = '<leader>ic'
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

        autocmd BufWritePre * call StripTrailingWhitespace()
    " }}}2

    " Show foldcolumn when folding exists {{{2
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

        autocmd BufWinEnter,BufLeave * call SetFoldcolumn()
        autocmd CursorHold * call UpdateFoldcolumn()
    " }}}2

    " Toggle fold state between closed and opened {{{2
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

        nnoremap <space> :<C-U>call ToggleFold()<CR>
    " }}}2

    " Customize foldtext {{{2
        function! CustomFoldtext()
            let indent = repeat(' ', indent(v:foldstart))
            let startLine = getline(v:foldstart)
            let endLine = getline(v:foldend)
            let windowWidth = winwidth(0) - &foldcolumn - &numberwidth - (YepNopeSigns()+0 ? 2 : 0)
            let foldSize = v:foldend - v:foldstart + 1
            let foldSizeStr = ' ' . foldSize . ' lines '
            let foldPercentage = printf("[%.1f", (foldSize * 1.0)/line('$') * 100) . "%] "
            let foldLevelStr = repeat('+--', v:foldlevel)
            " fold comments when setting foldmarker as /\*,\*/
            if match(startLine, '^[ \t]*/\*\(\(\W\|_\)\(\*/\)\@!\)*[ \t]*$') == 0 &&
                        \match(endLine, '^[ \t]*\(\(/\*\)\@<!\(\W\|_\)\)*\*/[ \t]*$') == 0
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
            " fold codes when setting foldmarker as {,}
            if match(startLine, '{\+\d\=\ze[ \t]*$') != -1 && match(endLine, '^[ \t"]*\zs}\+\d\=') != -1
                let startBracket = matchstr(startLine, '{\+\d\=\ze[ \t]*$')
                let temp = substitute(startLine, '{\+\d\=[ \t]*$', '', '')
                let startStr = substitute(temp, '^\t\+', indent, '')
                let endBracket = matchstr(endLine, '^[ \t"]*\zs}\+\d\=')
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

        function! YepNopeSigns()
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
        set foldtext=CustomFoldtext()

        " Quickly set foldmethod
        nnoremap <silent> <leader>fc :<C-U>setlocal foldmethod=marker foldmarker={,} foldtext=CustomFoldtext()<CR>
        nnoremap <silent> <leader>fv :<C-U>setlocal foldmethod=marker foldmarker=/\*,\*/ foldtext=CustomFoldtext()<CR>
    " }}}2

    " Smart NERDTree bookmarks list {{{2
        function! s:SmartNERDTreeBookmark()
            " initialize
            if !filereadable(g:NERDTreeBookmarksFile)
                silent! execute 'keepalt botright 1new'
                silent! execute 'edit ' . g:NERDTreeBookmarksFile
                silent! execute 'write!'
                silent! execute 'wincmd q'
                if !filereadable(g:NERDTreeBookmarksFile)
                    echohl WarningMsg | echo "g:NERDTreeBookmarksFile can't read!" | echohl None
                    return
                endif
            endif
            if !exists('s:bmContent')
                let s:bmContent = readfile(g:NERDTreeBookmarksFile)
            endif
            let desc = repeat(' ', 3) . '1-9 or CR = open, a = add, d = delete, D = delete all, e = edit, q or ESC = quit' . repeat(' ', 3)
            let desc = desc . "\n" . repeat('-', strlen(desc))
            " get the max len of bookmark name
            let nameMaxLen = 0
            for line in s:bmContent
                if line != ''
                    let name = substitute(line, '^\(.\{-1,}\) .\+$', '\1', '')
                    let nameMaxLen = strlen(name) > nameMaxLen ? strlen(name) : nameMaxLen
                endif
            endfor
            " formatting
            let output = []
            for line in s:bmContent
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
            if getline('$') == ''
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
                        call remove(s:bmContent, line('.')-3)
                        call insert(s:bmContent, newLine, line('.')-3)
                    else
                        return
                    endif
                    hide
                    call s:SmartNERDTreeBookmark()
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

        function! s:WriteBookmraksFile()
            if !filereadable(g:NERDTreeBookmarksFile)
                silent! execute 'keepalt botright 1new'
                silent! execute 'edit ' . g:NERDTreeBookmarksFile
                silent! execute 'write!'
                silent! execute 'wincmd q'
                if !filereadable(g:NERDTreeBookmarksFile)
                    echohl WarningMsg | echo "g:NERDTreeBookmarksFile can't read!" | echohl None
                    return
                endif
            endif
            if filewritable(g:NERDTreeBookmarksFile) == 0
                echohl WarningMsg | echo "g:NERDTreeBookmarksFile can't write!" | echohl None
                return
            endif
            if !exists('s:bmContent')
                let s:bmContent = readfile(g:NERDTreeBookmarksFile)
            endif
            call writefile(s:bmContent, g:NERDTreeBookmarksFile)
        endfunction

        " Save bookmark when leaving
        autocmd VimLeavePre * call s:WriteBookmraksFile()

        nnoremap <silent> <leader>nb :<C-U>call <SID>SmartNERDTreeBookmark()<CR>
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
                if a:handle == '+' && alpha < 255
                    let alpha = alpha+1
                endif
                if a:handle == '-' && alpha > 0
                    let alpha = alpha-1
                endif
                let s:frameParams = elem[0] . ' ' . elem[1] . ' ' . alpha . ' ' . &lines . ' ' . &columns . ' ' .
                            \(getwinposx()<0 ? 0 : getwinposx()) . ' ' .
                            \(getwinposy()<0 ? 0 : getwinposy())
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
                            \(getwinposy()<0 ? 0 : getwinposy())
                call s:RestoreFrameParams()
            endif
        endfunction

        function! s:InitFrameParams()
            let s:frameParams = v:servername . ' 0 255 ' . &lines . ' ' . &columns . ' ' .
                        \(getwinposx()<0 ? 0 : getwinposx()) . ' ' .
                        \(getwinposy()<0 ? 0 : getwinposy())
        endfunction

        function! s:RestoreFrameParams()
            let elem = split(s:frameParams)
            if elem[0] == v:servername
                if elem[1]+0
                    call libcallnr("vimtweak.dll", "EnableMaximize", 1)
                    call libcallnr("vimtweak.dll", "EnableCaption", 0)
                else
                    silent! execute 'set lines=' . elem[3] . ' columns=' . elem[4]
                    silent! execute 'winpos ' . elem[5] . ' ' .  elem[6]
                    call libcallnr("vimtweak.dll", "EnableCaption", 1)
                    call libcallnr("vimtweak.dll", "EnableMaximize", 0)
                endif
                call libcallnr("vimtweak.dll", "SetAlpha", elem[2]+0)
            endif
        endfunction

        function! s:WriteFrameParams()
            if !filereadable($HOME.'/.cache/.vimsize')
                silent! execute 'keepalt botright 1new'
                silent! execute 'edit ' . $HOME.'/.cache/.vimsize'
                silent! execute 'write!'
                silent! execute 'wincmd q'
                if !filereadable($HOME.'/.cache/.vimsize')
                    echohl WarningMsg | echo ".vimsize can't read!" | echohl None
                    return
                endif
            endif
            if filewritable($HOME.'/.cache/.vimsize') == 0
                echohl WarningMsg | echo ".vimsize can't write!" | echohl None
                return
            endif
            let elem = split(s:frameParams)
            if elem[0] == v:servername
                let newFrameParams = elem[0] . ' ' . elem[1] . ' ' . elem[2] . ' ' . &lines . ' ' . &columns . ' ' .
                            \(getwinposx()<0 ? 0 : getwinposx()) . ' ' .
                            \(getwinposy()<0 ? 0 : getwinposy())
            endif
            let content = readfile($HOME.'/.cache/.vimsize')
            let content = filter(content, "v:val !~# '^".v:servername." '")
            call add(content, newFrameParams)
            call writefile(content, $HOME.'/.cache/.vimsize')
        endfunction

        function! s:ReadFrameParams()
            if !filereadable($HOME.'/.cache/.vimsize')
                silent! execute 'keepalt botright 1new'
                silent! execute 'edit ' . $HOME.'/.cache/.vimsize'
                silent! execute 'write!'
                silent! execute 'wincmd q'
                if !filereadable($HOME.'/.cache/.vimsize')
                    echohl WarningMsg | echo ".vimsize can't read!" | echohl None
                    return
                endif
            endif
            let content = readfile($HOME.'/.cache/.vimsize')
            let content = filter(content, "v:val =~# '^".v:servername." '")
            if len(content) > 0
                let s:frameParams = content[-1]
            else
                call s:InitFrameParams()
            endif
            call s:RestoreFrameParams()
        endfunction

        nnoremap <silent> <F12> :<C-U>call <SID>AdjustFrameSize()<CR>
        nnoremap <silent> <C-Left> :<C-U>call <SID>AdjustFrameAlpha('-')<CR>
        nnoremap <silent> <C-Right> :<C-U>call <SID>AdjustFrameAlpha('+')<CR>

        autocmd VimEnter * call s:ReadFrameParams()
        autocmd VimLeavePre * call s:WriteFrameParams()
    " }}}2

    " Delete buffer while keeping window layout {{{2
        function! s:BClose(bang, buffer)
            if empty(a:buffer)
                let bTarget = bufnr('%')
            elseif a:buffer =~ '^\d\+$'
                " When a:buffer doesn't exist as number, try as string
                let bTarget = bufnr(a:buffer+0)>0 ? bufnr(a:buffer+0) : bufnr(a:buffer)
            else
                let bTarget = bufnr(a:buffer)
            endif
            if bTarget < 0
                echohl ErrorMsg | echo 'No matching buffer for Show the line and column number of the cursor position, separated by a' . a:buffer | echohl None
                return
            endif
            if empty(a:bang) && getbufvar(bTarget, '&modified')
                echohl WarningMsg | echo 'No write since last change for buffer ' . bTarget . ' (use :DeleteBuffer!)' | echohl None
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

        function! s:BHClose()
            let total = 0
            let protectedBufnameStr = '^\[SmartNERDTreeBookmark\]\|\[YankRing\]\|__Gundo_\|__Tagbar__\|NERD_tree_\|ControlP'
            let wCurrent = winnr()
            for w in range(1, winnr('$'))
                execute w . 'wincmd w'
                for bufNum in range(1, bufnr('$'))
                    if bufloaded(bufNum) && !buflisted(bufNum) && match(bufname(bufNum), protectedBufnameStr) == -1
                        execute 'bwipeout! ' . bufNum
                        let total = total + 1
                    endif
                endfor
            endfor
            execute wCurrent . 'wincmd w'
            if total > 0
                echo 'Deleted ' . total . ' hidden buffers'
            else
                echo 'No hidden buffers exist'
            endif
        endfunction

        command! -bang -complete=buffer -nargs=? BClose call s:BClose('<bang>', '<args>')
        nnoremap <silent> <Leader>bc :BClose<CR>

        command! -bang BHClose call s:BHClose()
        nnoremap <silent> <Leader>bhc :BHClose<CR>
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

    " Create directories for swap, backup, undo, view files if they don't exist {{{2
        function! s:InitializeDirectories()
            let parent = $HOME.'/.cache'
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
                    execute 'set ' . settingName . '=' . escape(substitute(expand(dir), '\\', '/', 'g'), ' ')
                    continue
                else
                    if exists('*mkdir')
                        call mkdir(dir, 'p')
                        execute 'set ' . settingName . '=' . escape(substitute(expand(dir), '\\', '/', 'g'), ' ')
                    else
                        echohl WarningMsg | echo 'Unable to create directory ' . dir . ' ,try to create manually.' | echohl None
                    endif
                endif
            endfor
        endfunction

        autocmd VimEnter * call s:InitializeDirectories()
    " }}}2

" }}}1
