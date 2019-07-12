syntax on

" Im old. I need optical help :D
set cursorline

" auto indention based on filtype
filetype plugin indent on

" comment line with cc and uncomment with cu
autocmd FileType sh,ruby,python         let b:comment_leader = '# '
autocmd FileType c,cpp,java,scala,js    let b:comment_leader = '// '
autocmd FileType conf,fstab             let b:comment_leader = '# '
autocmd FileType tex                    let b:comment_leader = '% '
autocmd FileType mail                   let b:comment_leader = '> '
autocmd FileType vim                    let b:comment_leader = '" '

noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" default tab handling
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set textwidth=79
set expandtab
set autoindent
set fileformat=unix

" tab handling specific by filetype
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype xml setlocal ts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 expandtab

" create a custom statusline
" many thanks to https://shapeshed.com/vim-statuslines/
" actual branch in statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" switch statusline on
set laststatus=2

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=\ %f                 "filename
set statusline+=\%m                  " modify flag
set statusline+=\ %r                 " read only flag
set statusline+=%=                   " divide between left and right
set statusline+=%#CursorColumn#
set statusline+=\ %y                 " type of file in buffer
set statusline+=\ %{&fileencoding?&fileencoding:&encoding} " show encoding of file
set statusline+=\[%{&fileformat}\]   " file format
set statusline+=\ %p%%               " position in percentage
set statusline+=\ %l:%c              " line and column position
set statusline+=\ 

