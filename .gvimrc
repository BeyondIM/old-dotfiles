" Use * register for copy-paste
set clipboard=unnamed

" Set extra options when running in GUI mode
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

if g:isWin
    set guifont=Consolas:h12:cANSI
    set guifontwide=Yahei_Mono:h11
endif
if g:isMac
    set guifont=Consolas:h16
    set guifontwide=Heiti\ SC\ Light:h16
    if has('gui_macvim')
        " activate option key in macvim
        set macmeta
    endif
endif

" vim: set shiftwidth=4 tabstop=4 softtabstop=4 expandtab foldmethod=marker:
