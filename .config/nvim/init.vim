" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Árbol de ficheros
Plug 'preservim/nerdtree'

" Auto-cerrar llaves, paréntesis, ...
Plug 'LunarWatcher/auto-pairs'
function! MoveCursorLeftIfNeeded()
    let col = col('.')
    if col > 1
        call feedkeys("\<C-Left>")
    endif
endfunction

" Presionando ,, vamos al princio del patrón que queremos sustituir
let mapleader = ","
nnoremap <leader>, :call MoveCursorLeftIfNeeded()<CR>
" Si presionamos ahora ,+",',(,\,[,{ rodeamos la palabra por los limitadores
" deseados (Para no tener que desacrivar auto-pairs para poner limites a palabras ya escritas)
nnoremap <leader>" :s/\%#\([^[:space:]]\+\)/"\1"/g<CR>:noh<CR>
nnoremap <leader>' :s/\%#\([^[:space:]]\+\)/'\1'/g<CR>:noh<CR>
nnoremap <leader>( :s/\%#\([^[:space:]]\+\)/(\1)/g<CR>:noh<CR>
nnoremap <leader>\ :s/\%#\([^[:space:]]\+\)/\\(\1\\)/g<CR>:noh<CR>
nnoremap <leader>[ :s/\%#\([^[:space:]]\+\)/[\1]/g<CR>:noh<CR>
nnoremap <leader>{ :s/\%#\([^[:space:]]\+\)/{\1}/g<CR>:noh<CR>

" Tema de colores
Plug 'ellisonleao/gruvbox.nvim'

" Pre-visualización de colores
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Hexokinase_highlighters = [
\   'sign_column',
\   'backgroundfull',
\ ]

" Ejecutar comandos de forma asíncrona
Plug 'skywind3000/asyncrun.vim'

" Sugerencias de entrada
Plug 'lervag/vimtex'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-vimtex'
inoremap <silent><expr> <tab> pumvisible() ? coc#pum#confirm() : "\<C-g>u\<tab>"

call plug#end()

" Opciones de vim
syntax enable
set title
set clipboard+=unnamedplus
set number relativenumber
set smarttab
set breakindent
set splitbelow splitright
set hidden
set ttimeoutlen=0
set ic
set ignorecase
set smartcase
set mouse=a
set noshowmode
set t_Co=256
set encoding=utf-8
set wildmode=longest,list,full
set autochdir
set cursorline
set incsearch
set scrolloff=10
set list

" Tema de colores
set background=dark
set termguicolors
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
if !has('gui_running')
  set t_Co=256
endif

" Activar/Desactivar sugerencias de entrada
inoremap <F1> <C-O>:call CocToggle()<CR>
nnoremap <F1> :call CocToggle()<CR>
" Abrir/Cerrar árbol de ficheros
inoremap <F2> <C-O>:call NERDTreeToggleInCurDir()<CR>
nnoremap <F2> :call NERDTreeToggleInCurDir()<CR>
" Comprobar ortografía
inoremap <F3> <C-O>:setlocal spell! spelllang=es_es<CR>
inoremap <F4> <C-O>:setlocal spell! spelllang=en_us<CR>
nnoremap <F3> :setlocal spell! spelllang=es_es<CR>
nnoremap <F4> :setlocal spell! spelllang=en_us<CR>
" Activar/Desactivar auto-cerrado de llaves, paréntesis, ...
inoremap <F5> <C-O>:AutoPairsToggle<CR>
nnoremap <F5> :AutoPairsToggle<CR>

" Sugerencias de entrada (Configuración)
let g:coc = 0

function! CocToggle()
    if g:coc
        CocEnable
        let g:coc = 0
    else
        CocDisable
        let g:coc = 1
    endif
endfunction

" Árbol de ficheros (Configuración)
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
endif
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    if (expand("%:t") != '')
      exe ":NERDTreeFind"
    else
      exe ":NERDTreeToggle"
    endif
  endif
endfunction

" Automatizar tareas cuando se escribe en un archivo
autocmd BufWritePost ~/.dotfiles/dwmblocks/blocks.h silent! !xterm -title scratchpad -e 'cd ~/.dotfiles/dwmblocks/; doas make install' && pkill dwmblocks; dwmblocks &
autocmd BufWritePost ~/.dotfiles/dwm/config.h silent! !xterm -title scratchpad -e 'cd ~/.dotfiles/dwm/; doas make install'
autocmd BufWritePost ~/.dotfiles/dmenu/config.h silent! !xterm -title scratchpad -e 'cd ~/.dotfiles/dmenu/; doas make install'
autocmd BufWritePost ~/.dotfiles/st/config.h silent! !xterm -title scratchpad -e 'cd ~/.dotfiles/st/; doas make install'
autocmd BufWritePost ~/.dotfiles/.config/sxhkd/sxhkdrc silent! !xterm -title scratchpad -e 'pkill sxhkd; sxhkd & disown; xdotool getwindowfocus windowunmap' & disown
autocmd BufWritePost ~/.dotfiles/.config/dunst/dunstrc :!pkill dunst; dunst &

" LaTeX
" Compilar archivo de texto a PDF
autocmd Filetype tex map <M-q> :AsyncRun! arara % && notify-send "Document Compiled" <CR><CR>
" Abrir PDF resultante en un visór de documentos
autocmd Filetype tex map <M-w> :! zathura $(echo % \| sed 's/tex$/pdf/') & 2>/dev/null <CR><CR>
autocmd Filetype tex map <M-e> :! xelatex % <CR>

" Groff
" Compilar documento Groff en un PDF
autocmd Filetype groff map <M-q> :! groff -ms % -T pdf > $(echo % \| sed 's/ms$/pdf/') <CR><CR>
" Abrir PDF resultante en un visór de documentos
autocmd Filetype groff map <M-w> :! zathura $(echo % \| sed 's/ms$/pdf/') & 2>/dev/null <CR><CR>
" Compilar documento Groff en un PDF (Con imágenes)
autocmd FIletype groff map <M-e> :! groff -ms % -Tps > $(echo % \| sed 's/ms$/ps/'); time ps2pdf $(echo % \| sed 's/ms$/ps/'); rm $(echo % \| sed 's/ms$/ps/') <CR>
" Pre-procesar con pic y compilar documento Groff en un PDF
autocmd Filetype groff map <M-a> :! pic % \| groff -ms -Tpdf > $(echo % \| sed 's/ms$/pdf/') <CR>
" Pre-procesar con pic y compilar documento Groff en un PDF (Con imágenes)
autocmd Filetype groff map <M-s> :! pic % \|  groff -ms -Tps > $(echo % \| sed 's/ms$/ps/'); time ps2pdf $(echo % \| sed 's/ms$/ps/'); rm $(echo % \| sed 's/ms$/ps/') <CR>

" C
autocmd Filetype c map <M-q> :! gcc % -o $(echo % \| sed 's/.c$//') -lm <CR>
autocmd Filetype c map <M-w> :terminal $PWD/$(echo % \| sed 's/.c$//')<CR>
autocmd Filetype c map <M-e> :terminal gdb $PWD/$(echo % \| sed 's/.c$//')<CR>

" Borrar automaticamente espacios inecesarios al guardar el archivo
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" Definir tipos de archivos
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.ms,*.me,*.mom set filetype=groff
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Ayuda
map <M-h> :echo "\n F1         Activar/Desactivar Sugestiones\n"
	\ . " F2         Activar/Desactivar Vista de Carpetas\n"
	\ . " F3         Activar Correciones (Español)\n"
	\ . " F4         Activar Correciones (Inglés)\n"
	\ . " F5         Desactivar/Activar Auto-Cerrado (LLaves, paréntesis, ...)\n"
	\ . " 'z'+'='    Corregir Palabra\n\n"
	\ . " laTeX:\n"
	\ . " Meta + Q   Compliar Documento (Con arara)\n"
	\ . " Meta + E   Compliar Documento (Con xelatex)\n"
	\ . " Meta + W   Abrir Documento\n\n"
	\ . " Groff:\n"
	\ . " Meta + Q   Compilar Documento (Sólo Texto)\n"
	\ . " Meta + W   Abrir Documento\n"
	\ . " Meta + E   Compilar Documento (Con Imágenes)\n"
	\ . " Meta + A   Compilar Documento (Preprocesar con Pic)\n"
	\ . " Meta + S   Compliar Documento (Preprocesar con Pic, con Imágenes)\n\n"
	\ . " C:\n"
	\ . " Meta + Q   Compilar con gcc\n"
	\ . " Meta + W   Ejecutar en terminal\n"
	\ . " Meta + E   Abrir en gdb"<CR>

" Auto acentuar caracteres con groff
" a
autocmd Filetype groff inoremap á  \['a] | autocmd Filetype groff inoremap Á  \['A]
autocmd Filetype groff inoremap â  \[^a] | autocmd Filetype groff inoremap Â  \[^A]
autocmd Filetype groff inoremap ä  \[:a] | autocmd Filetype groff inoremap Ä  \[:A]
" e
autocmd Filetype groff inoremap é  \['e] | autocmd Filetype groff inoremap É  \['E]
autocmd Filetype groff inoremap ê  \[^e] | autocmd Filetype groff inoremap Ê  \[^E]
autocmd Filetype groff inoremap ë  \[:e] | autocmd Filetype groff inoremap Ë  \[:E]
" i
autocmd Filetype groff inoremap í  \['i] | autocmd Filetype groff inoremap Í  \['I]
autocmd Filetype groff inoremap î  \[^i] | autocmd Filetype groff inoremap Î  \[^I]
autocmd Filetype groff inoremap ï  \[:i] | autocmd Filetype groff inoremap Ï  \[:I]
" o
autocmd Filetype groff inoremap ó  \['o] | autocmd Filetype groff inoremap Ó  \['O]
autocmd Filetype groff inoremap ô  \[^o] | autocmd Filetype groff inoremap Ô  \[^O]
autocmd Filetype groff inoremap ö  \[:o] | autocmd Filetype groff inoremap Ö  \[:O]
" u
autocmd Filetype groff inoremap ú  \['u] | autocmd Filetype groff inoremap Ú  \['U]
autocmd Filetype groff inoremap û  \[^u] | autocmd Filetype groff inoremap Û  \[^U]
autocmd Filetype groff inoremap ü  \[:u] | autocmd Filetype groff inoremap Ü  \[:U]
" Español
autocmd Filetype groff inoremap ñ  \[~n] | autocmd Filetype groff inoremap Ñ  \[~N]
autocmd Filetype groff inoremap ç  \[,c] | autocmd Filetype groff inoremap Ç  \[,C]
" Matemáticas
autocmd Filetype groff inoremap ·  \[pc] | autocmd Filetype groff inoremap ×  \[mu]
