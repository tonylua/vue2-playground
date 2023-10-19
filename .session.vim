let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/my_git/vue-source-editor-sample
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +21 src/main.js
badd +2 package.json
badd +1 vue.config.js
badd +81 src/App.vue
badd +23 term://~/my_git/vue-source-editor-sample//179:bash
badd +11 term://~/my_git/vue-source-editor-sample//356:bash
badd +0 node_modules/vue3-sfc-loader/dist/vue2-sfc-loader.js
badd +0 ~/my_git/vue-source-editor-sample/public/vue-sample/vue.config.js
badd +6 public/vue-sample/src/components/HelloWorld.vue
argglobal
%argdel
$argadd src/main.js
edit src/App.vue
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 31 + 88) / 176)
exe 'vert 2resize ' . ((&columns * 71 + 88) / 176)
exe 'vert 3resize ' . ((&columns * 72 + 88) / 176)
argglobal
enew
file NERD_tree_1
balt src/App.vue
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
wincmd w
argglobal
balt term://~/my_git/vue-source-editor-sample//356:bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 81 - ((39 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 81
normal! 012|
wincmd w
argglobal
if bufexists(fnamemodify("public/vue-sample/src/components/HelloWorld.vue", ":p")) | buffer public/vue-sample/src/components/HelloWorld.vue | else | edit public/vue-sample/src/components/HelloWorld.vue | endif
if &buftype ==# 'terminal'
  silent file public/vue-sample/src/components/HelloWorld.vue
endif
balt src/App.vue
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 3 - ((2 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 018|
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 88) / 176)
exe 'vert 2resize ' . ((&columns * 71 + 88) / 176)
exe 'vert 3resize ' . ((&columns * 72 + 88) / 176)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
