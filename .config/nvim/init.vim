" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Árbol de ficheros
Plug 'preservim/nerdtree'

" Auto-cerrar llaves, paréntesis, ...
Plug 'LunarWatcher/auto-pairs'

" Tema de colores
Plug 'ellisonleao/gruvbox.nvim'
Plug 'tribela/vim-transparent'

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
let g:transparent_groups = ['Normal', 'Comment', 'Constant', 'Special', 'Identifier',
                            \ 'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
                            \ 'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
                            \ 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr', 'EndOfBuffer']
let g:transparent_groups += ['NormalFloat', 'CocFloating']
set background=dark
set termguicolors
colorscheme gruvbox

if !has('gui_running')
  set t_Co=256
endif

" Activar/Desactivar sugerencias de entrada
nnoremap <F1> :call CocToggle()<CR>
" Abrir/Cerrar árbol de ficheros
map <F2> :NERDTreeToggle<CR>
" Comprobar ortografía
map <F3> :setlocal spell! spelllang=es_es<CR>
map <F4> :setlocal spell! spelllang=en_us<CR>
" Activar/Desactivar auto-cerrado de llaves, paréntesis, ...
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
nnoremap <C-M-ñ> :call NERDTreeToggleInCurDir()<cr>
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
autocmd BufWritePost ~/.dotfiles/.config/sxhkd/sxhkdrc silent! !xterm -title scratchpad -e 'pkill sxhkd; sxhkd & disown; xdotool getwindowfocus windowunmap' & disown
autocmd BufWritePost ~/.dotfiles/.config/sxhkd/sxhkdrc :!pkill sxhkd; sxhkd &
autocmd BufWritePost ~/.dotfiles/.config/dunst/dunstrc :!pkill dunst; dunst &

" LaTeX
" Compilar archivo de texto a PDF
autocmd Filetype tex map <M-q> :! arara % <CR>
" Abrir PDF resultante en un visór de documentos
autocmd Filetype tex map <M-w> :! zathura $(echo % \| sed 's/tex$/pdf/') & 2>/dev/null <CR><CR>

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

" Cargar plantillas
au BufNewFile * silent! 0r /home/aleister/.config/nvim/templates/%:e.tpl
filetype plugin indent on

" Borrar automaticamente espacios inecesarios al guardar el archivo
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" Definir tipos de archivos
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
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
	\ . " Meta + Q   Compliar Documento\n"
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
autocmd Filetype groff inoremap à  \[`a] | autocmd Filetype groff inoremap À  \[`A]
autocmd Filetype groff inoremap ä  \[:a] | autocmd Filetype groff inoremap Ä  \[:A]
autocmd Filetype groff inoremap ã  \[~a] | autocmd Filetype groff inoremap Ã  \[~A]
autocmd Filetype groff inoremap å  \[oa] | autocmd Filetype groff inoremap Å  \[oA]
autocmd Filetype groff inoremap æ  \[ae] | autocmd Filetype groff inoremap Æ  \[AE]
" e
autocmd Filetype groff inoremap é  \['e] | autocmd Filetype groff inoremap É  \['E]
autocmd Filetype groff inoremap ê  \[^e] | autocmd Filetype groff inoremap Ê  \[^E]
autocmd Filetype groff inoremap è  \[`e] | autocmd Filetype groff inoremap È  \[`E]
autocmd Filetype groff inoremap ë  \[:e] | autocmd Filetype groff inoremap Ë  \[:E]
" i
autocmd Filetype groff inoremap í  \['i] | autocmd Filetype groff inoremap Í  \['I]
autocmd Filetype groff inoremap î  \[^i] | autocmd Filetype groff inoremap Î  \[^I]
autocmd Filetype groff inoremap ì  \[`i] | autocmd Filetype groff inoremap Ì  \[`I]
autocmd Filetype groff inoremap ï  \[:i] | autocmd Filetype groff inoremap Ï  \[:I]
" o
autocmd Filetype groff inoremap ó  \['o] | autocmd Filetype groff inoremap Ó  \['O]
autocmd Filetype groff inoremap ô  \[^o] | autocmd Filetype groff inoremap Ô  \[^O]
autocmd Filetype groff inoremap ò  \[`o] | autocmd Filetype groff inoremap Ò  \[`O]
autocmd Filetype groff inoremap ö  \[:o] | autocmd Filetype groff inoremap Ö  \[:O]
autocmd Filetype groff inoremap õ  \[~o] | autocmd Filetype groff inoremap Õ  \[~O]
autocmd Filetype groff inoremap ø  \[/o] | autocmd Filetype groff inoremap Ø  \[/O]
autocmd Filetype groff inoremap ð  \[Sd]
" u
autocmd Filetype groff inoremap ú  \['u] | autocmd Filetype groff inoremap Ú  \['U]
autocmd Filetype groff inoremap û  \[^u] | autocmd Filetype groff inoremap Û  \[^U]
autocmd Filetype groff inoremap ù  \[`u] | autocmd Filetype groff inoremap Ù  \[`U]
autocmd Filetype groff inoremap ü  \[:u] | autocmd Filetype groff inoremap Ü  \[:U]
" y
autocmd Filetype groff inoremap ý  \['y] | autocmd Filetype groff inoremap Ý  \['Y]
autocmd Filetype groff inoremap ÿ  \[:y] | autocmd Filetype groff inoremap Ÿ  \[:Y]
" Español
autocmd Filetype groff inoremap ñ  \[~n] | autocmd Filetype groff inoremap Ñ  \[~N]
autocmd Filetype groff inoremap ç  \[,c] | autocmd Filetype groff inoremap Ç  \[,C]
" Matemáticas
autocmd Filetype groff inoremap ·  \[pc] | autocmd Filetype groff inoremap ±  \[+-]
autocmd Filetype groff inoremap ×  \[mu] | autocmd Filetype groff inoremap ÷  \[di]
autocmd FIletype groff inoremap ¼  \[14] | autocmd FIletype groff inoremap ½  \[12]
autocmd FIletype groff inoremap ¾  \[34] | autocmd FIletype groff inoremap ⅓  \[13]
autocmd FIletype groff inoremap ⅔  \[23] | autocmd FIletype groff inoremap ⅕  \[15]
autocmd FIletype groff inoremap ⅖  \[25] | autocmd FIletype groff inoremap ⅗  \[35]
autocmd FIletype groff inoremap ⅘  \[45] | autocmd FIletype groff inoremap ⅙  \[16]
autocmd FIletype groff inoremap ⅚  \[56] | autocmd FIletype groff inoremap ⅛  \[18]
autocmd FIletype groff inoremap ⅜  \[38] | autocmd FIletype groff inoremap ⅝  \[58]
autocmd FIletype groff inoremap ⅞  \[78] | autocmd Filetype groff inoremap ¹  \[S1]
autocmd Filetype groff inoremap ²  \[S2] | autocmd Filetype groff inoremap ³  \[S3]
autocmd Filetype groff inoremap «  \[Fo] | autocmd Filetype groff inoremap »  \[Fc]
