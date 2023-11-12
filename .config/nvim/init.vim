"        _      _     _            ___   ___   ___               _                              __ _
"   __ _| | ___(_)___| |_ ___ _ __( _ ) ( _ ) ( _ )   _ ____   _(_)_ __ ___     ___ ___  _ __  / _(_) __ _
"  / _` | |/ _ \ / __| __/ _ \ '__/ _ \ / _ \ / _ \  | '_ \ \ / / | '_ ` _ \   / __/ _ \| '_ \| |_| |/ _` |
" | (_| | |  __/ \__ \ ||  __/ | | (_) | (_) | (_) | | | | \ V /| | | | | | | | (_| (_) | | | |  _| | (_| |
"  \__,_|_|\___|_|___/\__\___|_|  \___/ \___/ \___/  |_| |_|\_/ |_|_| |_| |_|  \___\___/|_| |_|_| |_|\__, |
"                                                                                                    |___/

" --- Plugins ---
call plug#begin('~/.local/share/nvim/plugged')

" Filetree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons' " Icons for nerdtree

" Syntax highlighting
Plug 'frazrepo/vim-rainbow' " Symbols syntax highlighting
Plug 'Gavinok/vim-troff' " Syntax highlighting for .troff files
Plug 'kovetskiy/sxhkd-vim' " sxhkd config file syntax highlighting
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Color previews
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
let skip_defaults_vim=1
let g:rainbow_active = 1
Plug 'vim-pandoc/vim-pandoc-syntax' " Pandoc syntax highlighting
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespaces

" Appearance
Plug 'itchyny/lightline.vim' " Status line appearance
Plug 'NLKNguyen/papercolor-theme' " Theme

" Smooth Scrolling
Plug 'psliwka/vim-smoothie'

" Vim LaTeX
Plug 'lervag/vimtex'

" Autosugestions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-vimtex'
inoremap <silent><expr> <tab> pumvisible() ? coc#pum#confirm() : "\<C-g>u\<tab>"

" Fuzzyfinder Plugin
Plug 'ctrlpvim/ctrlp.vim'
nnoremap <M-3> :CtrlP<cr>

" Notepad++-Like Search Function
Plug 'kenng/vim-bettersearch'
nnoremap <M-S-7> :BetterSearchPromptOn<CR>

call plug#end()



" --- Options ---
syntax enable
set title
set clipboard+=unnamedplus
set number relativenumber
set smarttab
set breakindent
set splitbelow splitright
set spelllang=es
set hidden
set ttimeoutlen=0
set ic
set ignorecase
set smartcase
set pastetoggle=<F3>
set mouse=a
set noshowmode
set termguicolors
set t_Co=256
set encoding=utf-8
set wildmode=longest,list,full
set autochdir
set cursorline
set incsearch
set scrolloff=10
set list



" --- Colorscheme ---
set t_Co=256   " This is may or may not needed.
set background=dark
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }
colorscheme PaperColor



" --- Ctrlpvim options ---
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(wav|pdf|exe|so|dll|flac
  \ |png|eps|mid|gp5|gp4|gp3|gp|tg
  \ |mp3|reapeaks|mp3)$',
  \ }



" --- Limelight ---
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
let g:limelight_priority = -1



" --- Spellchecking ---
map <M-z> :setlocal spell! spelllang=es_es<CR>
map <C-z> :e ~/.config/nvim/spell/es.utf-8.add
map <M-x> :setlocal spell! spelllang=en_us<CR>
map <C-x> :e ~/.config/nvim/spell/en.utf-8.add



" --- Toggle autocompletion ---
nnoremap <M-1> :call CocToggle()<cr>

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



" --- Nerdtree ---
map <M-4> :NERDTreeToggle<CR>
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



" --- AUTOCOMPILE/RESTART ---
autocmd BufWritePost ~/.dotfiles/dwmblocks/blocks.h silent! !xterm -title scratchpad -e 'cd ~/.dotfiles/dwmblocks/; doas make install' && pkill dwmblocks; dwmblocks &
autocmd BufWritePost ~/.dotfiles/dwm/config.h silent! !xterm -title scratchpad -e 'cd ~/.dotfiles/dwm/; doas make install'
autocmd BufWritePost ~/.dotfiles/dmenu/config.h silent! !xterm -title scratchpad -e 'cd ~/.dotfiles/dmenu/; doas make install'
autocmd BufWritePost ~/.dotfiles/.config/sxhkd/sxhkdrc silent! !xterm -title scratchpad -e 'pkill sxhkd; sxhkd & disown; xdotool getwindowfocus windowunmap' & disown


" --- LaTeX ---
" Compile laTeX document into PDF
autocmd Filetype tex map <M-q> :! arara % <CR>
" Open compiled laTeX document as PDF
autocmd Filetype tex map <M-w> :! zathura $(echo % \| sed 's/tex$/pdf/') & 2>/dev/null <CR><CR>



" --- Markdown ---
" Compile Markdown document into PDF
autocmd Filetype markdown map <M-q> :! pandoc % -o $(echo % \| sed 's/md$/pdf/') --lua-filter ~/.config/nvim/columns/columns.lua --pdf-engine=xelatex --variable mainfont="Linux Biolinum" -V geometry:margin=0.75in -V fontsize=14pt <CR>
" Open compiled Markdown document as PDF
autocmd Filetype markdown map <M-w> :! zathura $(echo % \| sed 's/md$/pdf/') & 2>/dev/null <CR><CR>



" --- Groff ---
" Compile Groff document into PDF
autocmd Filetype groff map <M-q> :! groff -ms % -T pdf > $(echo % \| sed 's/ms$/pdf/') <CR><CR>
" Open compiled Groff document as PDF
autocmd Filetype groff map <M-w> :! zathura $(echo % \| sed 's/ms$/pdf/') & 2>/dev/null <CR><CR>
" Compile Groff document (With images)
autocmd FIletype groff map <M-e> :! groff -ms % -Tps > $(echo % \| sed 's/ms$/ps/'); time ps2pdf $(echo % \| sed 's/ms$/ps/'); rm $(echo % \| sed 's/ms$/ps/') <CR>
" Compile Groff document preprocessing with pic
autocmd Filetype groff map <M-a> :! pic % \| groff -ms -Tpdf > $(echo % \| sed 's/ms$/pdf/') <CR>
" Compile Groff document preprocessing with pic, (With images)
autocmd Filetype groff map <M-s> :! pic % \|  groff -ms -Tps > $(echo % \| sed 's/ms$/ps/'); time ps2pdf $(echo % \| sed 's/ms$/ps/'); rm $(echo % \| sed 's/ms$/ps/') <CR>



" --- C ---
autocmd Filetype c map <M-q> :! gcc % -o $(echo % \| sed 's/.c$//') -lm <CR>
autocmd Filetype c map <M-w> :terminal $PWD/$(echo % \| sed 's/.c$//')<CR>
autocmd Filetype c map <M-e> :terminal gdb $PWD/$(echo % \| sed 's/.c$//')<CR>



" --- Load templates ---
au BufNewFile * silent! 0r /home/aleister/.config/nvim/templates/%:e.tpl
filetype plugin indent on



" --- File syntax ---
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
augroup pandoc_syntax
	au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc_syntax
augroup END



" --- Lightline colorscheme ---
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }



" --- Vimtex options ---
let g:vimtex_compiler_method = 'arara'
let g:vimtex_compiler_arara = {
    \ 'options' : [],
    \ 'hooks' : [],
    \}
let g:vimtex_fold_manual = 1
let g:vimtex_view_method = 'zathura'



" --- Define filetypes ---
autocmd BufRead,BufNewFile *.ms,*.me,*.mom set filetype=groff
autocmd BufRead,BufNewFile *.md set filetype=markdown



" --- Help ---
map <M-h> :echo "\n Meta + 1	Activar/Desactivar Sugestiones\n Meta + 3	CtrlP\n Meta + 4	Activar/Desactivar Vista de Carpetas\n\n Meta + Z	Activar Correciones	(Español)\n Meta + X	Activar Correciones	(Inglés)\n Ctrl + Z	Añadir al diccionario	(Español)\n Ctrl + X	Añadir al diccionario	(Inglés)\n\n Latex/Markdown:\n Meta + Q	Compliar Documento\n Meta + W	Abrir Documento\n\n Groff:\n Meta + Q	Compilar Documento (Sólo Texto)\n Meta + W	Abrir Documento\n Meta + E	Compilar Documento (Con Imágenes)\n Meta + A	Compilar Documento (Preprocesar con Pic)\n Meta + S	Compliar Documento (Preprocesar con Pic, Con Imágenes)\n\n C:\n Meta + Q	Compilar con gcc\n Meta + W	Ejecutar en terminal\n Meta + E	Abrir en gdb"<CR>



" --- Groff auto accents ---
autocmd Filetype groff inoremap á  \['a]
autocmd Filetype groff inoremap Á  \['A]
autocmd Filetype groff inoremap é  \['e]
autocmd Filetype groff inoremap É  \['E]
autocmd Filetype groff inoremap í  \['i]
autocmd Filetype groff inoremap Í  \['I]
autocmd Filetype groff inoremap ó  \['o]
autocmd Filetype groff inoremap ú  \['u]
autocmd Filetype groff inoremap Ú  \['U]
autocmd Filetype groff inoremap ñ  \[~n]
autocmd Filetype groff inoremap Ñ  \[~N]
autocmd Filetype groff inoremap ç  \[,c]
autocmd Filetype groff inoremap Ç  \[,C]
autocmd Filetype groff inoremap ¡  \[r!]
autocmd Filetype groff inoremap ¢  \[ct]
autocmd Filetype groff inoremap Ò  \[`O]
autocmd Filetype groff inoremap £  \[Po]
autocmd Filetype groff inoremap Ó  \['O]
autocmd Filetype groff inoremap ¤  \[Cs]
autocmd Filetype groff inoremap Ô  \[^]O
autocmd Filetype groff inoremap ¥  \[Ye]
autocmd Filetype groff inoremap Õ  \[~O]
autocmd Filetype groff inore volidmap ¦  \[bb]
autocmd Filetype groff inoremap Ö  \[:O]
autocmd Filetype groff inoremap §  \[sc]
autocmd Filetype groff inoremap ×  \[mu]
autocmd Filetype groff inoremap ¨  \[ad]
autocmd Filetype groff inoremap Ø  \[/O]
autocmd Filetype groff inoremap ©  \[co]
autocmd Filetype groff inoremap Ù  \[`U]
autocmd Filetype groff inoremap ª  \[Of]
autocmd Filetype groff inoremap Ú  \['U]
autocmd Filetype groff inoremap «  \[Fo]
autocmd Filetype groff inoremap Û  \[^U]
autocmd Filetype groff inoremap ¬  \[no]
autocmd Filetype groff inoremap Ü  \[:U]
autocmd Filetype groff inoremap ®  \[rg]
autocmd Filetype groff inoremap Ý  \['Y]
autocmd Filetype groff inoremap ¯  \[a-]
autocmd Filetype groff inoremap Þ  \[TP]
autocmd Filetype groff inoremap °  \[de]
autocmd Filetype groff inoremap ß  \[ss]
autocmd Filetype groff inoremap ±  \[+-]
autocmd Filetype groff inoremap à  \[`a]
autocmd Filetype groff inoremap ²  \[S2]
autocmd Filetype groff inoremap ³  \[S3]
autocmd Filetype groff inoremap â  \[^a]
autocmd Filetype groff inoremap ´  \[aa]
autocmd Filetype groff inoremap ã  \[~a]
autocmd Filetype groff inoremap µ  \[mc]
autocmd Filetype groff inoremap ä  \[:a]
autocmd Filetype groff inoremap ¶  \[ps]
autocmd Filetype groff inoremap å  \[oa]
autocmd Filetype groff inoremap ·  \[pc]
autocmd Filetype groff inoremap æ  \[ae]
autocmd Filetype groff inoremap ¸  \[ac]
autocmd Filetype groff inoremap ¹  \[S1]
autocmd Filetype groff inoremap è  \[`e]
autocmd Filetype groff inoremap º  \[Om]
autocmd Filetype groff inoremap »  \[Fc]
autocmd Filetype groff inoremap ê  \[^e]
autocmd Filetype groff inoremap ¼  \[14]
autocmd Filetype groff inoremap ë  \[:e]
autocmd Filetype groff inoremap ½  \[12]
autocmd Filetype groff inoremap ì  \[`i]
autocmd Filetype groff inoremap ¾  \[34]
autocmd Filetype groff inoremap ¿  \[r?]
autocmd Filetype groff inoremap î  \[^i]
autocmd Filetype groff inoremap À  \[`A]
autocmd Filetype groff inoremap ï  \[:i]
autocmd Filetype groff inoremap ð  \[Sd]
autocmd Filetype groff inoremap Â  \[^A]
autocmd Filetype groff inoremap Ã  \[~A]
autocmd Filetype groff inoremap ò  \[`o]
autocmd Filetype groff inoremap Ä  \[:A]
autocmd Filetype groff inoremap Å  \[oA]
autocmd Filetype groff inoremap ô  \[^o]
autocmd Filetype groff inoremap Æ  \[AE]
autocmd Filetype groff inoremap õ  \[~o]
autocmd Filetype groff inoremap ö  \[:o]
autocmd Filetype groff inoremap È  \[`E]
autocmd Filetype groff inoremap ÷  \[di]
autocmd Filetype groff inoremap ø  \[/o]
autocmd Filetype groff inoremap Ê  \[^E]
autocmd Filetype groff inoremap ù  \[`u]
autocmd Filetype groff inoremap Ë  \[:E]
autocmd Filetype groff inoremap Ì  \[`I]
autocmd Filetype groff inoremap û  \[^u]
autocmd Filetype groff inoremap ü  \[:u]
autocmd Filetype groff inoremap Î  \[^I]
autocmd Filetype groff inoremap ý  \['y]
autocmd Filetype groff inoremap Ï  \[:I]
autocmd Filetype groff inoremap þ  \[Tp]
autocmd Filetype groff inoremap Ð  \[-D]
autocmd Filetype groff inoremap ÿ  \[:y]
