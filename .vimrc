" BusyBox vim may need .vimrc to de renamed /root/.exrc or /etc/vim/vimrc
set ignorecase
" BusyBox vim may not like/know these two options:
scriptencoding utf-8
set encoding=utf-8
" BusyBox vim may not contain syntax files, so comment out:
syntax on
colorscheme murphy
" smartindent et al.:
set expandtab      " Convert tabs to spaces
set smartindent    " Use smart indenting
"set tabstop=4      " Number of spaces a <Tab> in the file counts for
"set shiftwidth=4   " Number of spaces to use for each step of indent
"set softtabstop=4  " Number of spaces a <Tab> counts for while performing editing
" Prevent Ins key toggling to the Replace mode (which can still be activated by R key):
imap <Insert> <Nop>
