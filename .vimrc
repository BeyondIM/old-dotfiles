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
    " }}}2

    " Windows Compatible {{{2
        if g:isWin
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }}}2

    " Runtimepath render {{{2
        runtime bundle/vim-pathogen/autoload/pathogen.vim
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
        " Align
        Script '294'
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
        " Fix slow O inserts
        set timeout timeoutlen=1000 ttimeoutlen=100
        " With a map leader it's possible to do extra key combinations
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
        " Don't show mode
        set noshowmode
        " Pause listings when the screen is full
        set more
        " Start a dialog when a command fails
        set confirm
        " Ignore changes in amount of white space
        set diffopt-=iwhite
        " Only insert one space after a '.', '?' and '!' with join command
        set nojoinspaces
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
        augroup normalAutocmd
            autocmd!
            " Return to last edit position when opening files
            autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g`\"" | endif

            " Highlight current line and cursor when in insert mode
            autocmd InsertLeave * set nocursorline
            autocmd InsertEnter * set cursorline

            " Resize splits when the window is resized
            autocmd VimResized * execute "normal! \<c-w>="
        augroup END

        " OmniComplete
        autocmd filetype * if exists('+omnifunc') && empty(&omnifunc) |
                    \setlocal omnifunc=syntaxcomplete#Complete |
                    \endif

        " Customize indent style
        autocmd FileType html,xhtml,css,javascript,ruby,eruby setlocal tabstop=2 shiftwidth=2 softtabstop=2

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
        nnoremap <C-h> <C-W>h<C-W>_
        nnoremap <C-j> <C-W>j<C-W>_
        nnoremap <C-k> <C-W>k<C-W>_
        nnoremap <C-l> <C-W>l<C-W>_

        " Keep search matches in the middle of the window.
        nnoremap n nzzzv
        nnoremap N Nzzzv

        " Fast saving
        nnoremap <Leader>w :<C-U>w!<CR>

        " Toggle search highlighting
        nnoremap <silent> <Leader>/ :set hlsearch! hlsearch?<CR>

        " Invert 'foldenable'
        nnoremap <Leader>= :set foldenable! foldenable?<CR>

        " Toggle wrap lines
        nnoremap <silent> <F2> :set wrap! wrap?<CR>

        " Toggle listchars
        nnoremap <silent> <F3> :set list! list?<CR>
        imap <F3> <C-O><F3>
        xmap <F3> <Esc><F3>gv

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
        let s:extensionName = ['lib', 'so', 'obj', 'pdf', 'jpeg', 'jpg', 'png', 'gif', 'zip', 'rar', '7z', 'z', 'bz2', 'tar', 'gz', 'tgz', 
                    \'exe', 'com', 'dll', 'ocx', 'drv', 'sys', 'docx', 'doc', 'xlsx', 'xls', 'pptx', 'ppt']
        let NERDTreeIgnore=['\c\.\(' . join(s:extensionName, '\|') . '\)$']
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
                    \'file' : '\c\.\(' . join(s:extensionName, '\|') . '\)$'
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
    " }}}2

    " Syntastic {{{2
        let g:syntastic_stl_format = 'L:%F, %E{Err:%e}%B{ }%W{Warn:%w}'
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

    " YouCompleteMe {{{2
        let g:ycm_key_invoke_completion = '<C-z>'
    " }}}2

    " Ultisnips {{{2
        let g:UltiSnipsExpandTrigger="<c-j>"
        let g:UltiSnipsJumpForwardTrigger="<c-j>"
        let g:UltiSnipsJumpBackwardTrigger="<c-k>"
    " }}}2

    " Vim-util {{{2
        let g:darkColors = ['jellybeans', 'molokai']
        let g:lightColors = ['mayansmoke']
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
        autocmd filetype vim,javascript,css setlocal foldtext=CustomFoldtext()
    " }}}2

    " Preview markdown file via Marked.app on Mac OS X {{{2
        function! s:PreviewMarkdown()
            if !g:isMac
                echohl ErrorMsg | echo 'This function previewing markdown file via Marked only works on Mac OS X.' | echohl None
                return
            endif
            if !executable('pandoc')
                echohl ErrorMsg | echo 'Please install pandoc first.' | echohl None
                return
            endif
            let temp = tempname() . '.md'
            let content = getline(1, '$')
            let newContent = []
            if expand("%:p:h:h:t",1) == 'notes-md'
                for line in content
                    let str = matchstr(line, '\(!\[.*\](\)\@<=.\+\.\%(png\|jpe\=g\|gif\)')
                    if str != "" && match(str, '^https\=:\/\/') == -1
                        let newLine = substitute(line, '\(!\[.*\]\)(' . str . ')',
                                    \'\1(' . expand("%:p:h:h",1) . '/images/' . expand("%:p:h:t", 1) . '/' . str . ')', 'g')
                    else
                        let newLine = line
                    endif
                    call add(newContent, newLine)
                endfor
            else
                for line in content
                    call add(newContent, line)
                endfor
            endif
            call writefile(newContent, temp)
            silent! execute '!open -a "Marked 2.app" ' . temp
        endfunction
        nnoremap <silent> <Leader>md :call <SID>PreviewMarkdown()<CR>
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

    " Rename current file {{{2
        function! s:RenameFile()
            let old_name = expand('%')
            let new_name = input('New file name: ', expand('%'), 'file')
            if new_name != '' && new_name != old_name
                execute ':saveas ' . new_name
                execute ':silent !rm ' . old_name
                redraw!
            endif
        endfunction
        nnoremap <leader>r :call <SID>RenameFile()<cr>
    " }}}2

    " Remove fancy characters {{{2
        function! s:RemoveFancyCharacters()
            let typo = {}
            let typo["“"] = '"'
            let typo["”"] = '"'
            let typo["‘"] = "'"
            let typo["’"] = "'"
            let typo["–"] = '--'
            let typo["—"] = '---'
            let typo["…"] = '...'
            execute ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
        endfunction
        command! RemoveFancyCharacters :call <SID>RemoveFancyCharacters()
    " }}}2

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

" }}}1

" vim: set shiftwidth=4 tabstop=4 softtabstop=4 expandtab foldmethod=marker:
