set number
set tabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=120
set nowrap
" avoid the status to block Jedi-Vim's call signature display in command line
set noshowmode
let mapleader = ','

" Use vertical line as cursor in insert mode
let &t_SI = "\e[6 q"
" Use block cursor in normal mode
let &t_EI = "\e[2 q"

call plug#begin('~/.vim/plugged')

" Python syntax highlighting
Plug 'sheerun/vim-polyglot'

" Autocompletion plugin
Plug 'davidhalter/jedi-vim'

Plug 'psf/black', { 'branch': 'stable' }

call plug#end()

filetype plugin indent on

" Jedi-Vim configuration
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 1
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#show_call_signatures = 2
set pumheight=10

" Supertab configuration
let g:SuperTabDefaultCompletionType = '<C-N>'

function! FormatWithBlack()
    execute 'Black'
endfunction

autocmd FileType python nnoremap <buffer> <leader>f :call FormatWithBlack()<CR>

function! ListLeaderMappings()
    let l:leader_key = mapleader
    if l:leader_key == ""
        let l:leader_key = "\<Space>"
    endif

    " Get all normal mode mappings
    redir @a
    silent! map
    redir END
    let l:mappings = split(@a, "\n")

    " Filter mappings that use the leader key
    echo "Leader key mappings:"
    for mapping in l:mappings
        if mapping =~ '^n' . l:leader_key
            echo mapping
        endif
    endfor
endfunction

" Map the function to a key (e.g., <leader>lm for "leader mappings")
nnoremap <leader>lm :call ListLeaderMappings()<CR>

syntax on
