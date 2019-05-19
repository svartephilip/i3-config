
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin thingy
" if empty(glob('~/.config/nvim/site/autoload/plug.vim'))
"   silent !curl -fLo ~/.config/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'ajh17/VimCompletesMe'
Plug 'dhruvasagar/vim-table-mode'
Plug 'tkhren/vim-fake'
Plug 'dkarter/bullets.vim'
Plug 'rhysd/vim-grammarous'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

Plug 'dylanaraps/wal.vim'

call plug#end()

" Enable filetype plugins
filetype plugin on
filetype indent on

"" Get a nonsense text like Lorem ipsum
call fake#define('sentense', 'fake#capitalize('
                        \ . 'join(map(range(fake#int(3,15)),"fake#gen(\"nonsense\")"))'
                        \ . ' . fake#chars(1,"..............!?"))')

call fake#define('paragraph', 'join(map(range(fake#int(3,10)),"fake#gen(\"sentense\")"))')

" let maplocalleader = "'"
map <leader>s :source ~/.config/nvim/init.vim<CR> " \+s to reload config
map <leader>s :source  $MYVIMRC<CR> " \+s to reload config
map <leader>ev :vsplit $MYVIMRC<cr>
set hlsearch    " Highlight search results
set lazyredraw  " Don't redraw while executing macros (good performance config)
set autoread    " Set to auto read when a file is changed from the outside
colorscheme wal

" :W sudo saves the file
" (useful for handling the permission-denied error)
"command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-pandoc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pandoc#modules#enabled = ["keyboard"]
let g:pandoc#modules#enabled = ["command"]
let g:pandoc#keyboard#use_default_mappings = 1
" let g:pandoc#command#autoexec_on_writes = 1
" let g:pandoc#command#autoexec_command = 'Pandoc pdf'
let g:pandoc#command#use_message_buffers = 1
let g:pandoc#command#custom_open = "MyPandocOpen"

function! MyPandocOpen(file)
	let file = shellescape(fnamemodify(a:file, ':p'))
	let file_extension = fnamemodify(a:file, ':e')
	if file_extension is? 'pdf'
	  if !empty($PDFVIEWER)
	    return expand('$PDFVIEWER') . ' ' . file
	  elseif executable('llpp')
	    return 'llpp ' . file
	  elseif executable('mupdf')
	    return 'mupdf ' . file
	  endif
	elseif file_extension is? 'html'
	  if !empty($BROWSER)
	    return expand('$BROWSER') . ' ' . file
	  elseif executable('surf')
	    return 'surf ' . file
	  elseif executable('firefox')
	    return 'firefox ' . file
	  endif
	elseif file_extension is? 'odt' && executable('okular')
	  return 'okular ' . file
	elseif file_extension is? 'epub' && executable('okular')
	  return 'okular ' . file
	else
	  return 'xdg-open ' . file
	endif
endfunction

let g:pencil#conceallevel = 0
let g:pencil#wrapModeDefault = 'soft'

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" display settings
set encoding=utf-8 " encoding used for displaying file

" search settings
set showmatch " highlight matching braces
set incsearch
set ignorecase
map <silent> <leader><cr> :nohlsearch<Bar>:echo<CR> " ability to cancel search
map <leader>g :Goyo 110<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smarttab     " Be smart when using tabs ;)
set shiftwidth=4 " 1 tab == 4 spaces
set tabstop=4    " 1 tab == 4 spaces

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
map <leader>gg :GrammarousCheck<cr>
map <leader>GG :GrammarousReset<cr>

" Shortcuts using <leader>
map <leader>sn ]s " goto next misspelled word
map <leader>sp [s " goto previous misspelled word
map <leader>sa zg " ad to dictionary
map <leader>sd z= " suggested words

nmap <leader>gp :<Plug>(grammarous-move-to-previous-error)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

let g:table_mode_corner = '+'
let g:table_mode_corner_corner='+'
" let g:table_mode_header_fillchar='='
