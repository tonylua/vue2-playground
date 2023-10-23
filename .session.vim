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
badd +55 src/App.vue
badd +109341 node_modules/vue3-sfc-loader/dist/vue2-sfc-loader.js
badd +13 src/sfc-utils.js
badd +56 term://~/my_git/vue-source-editor-sample//16781:bash
badd +0 package.json
badd +554 node_modules/systemjs/dist/s.js
badd +5 term://~/my_git/vue-source-editor-sample//17385:bash
badd +0 public/vue-sample/dist/component.js.map
badd +1 public/vue-sample/dist/component.js
badd +7 public/vue-sample/package.json
badd +4 public/vue-sample/vue.config.js
badd +33 term://~/my_git/vue-source-editor-sample//17844:bash
badd +26 term://~/my_git/vue-source-editor-sample//17923:bash
badd +16 term://~/my_git/vue-source-editor-sample//18045:bash
badd +15 vue.config.js
badd +1 public/vue-sample/babel.config.js
badd +26 term://~/my_git/vue-source-editor-sample//18744:bash
badd +11 public/vue-sample/src/components/HelloRemote.vue
badd +65 term://~/my_git/vue-source-editor-sample//18833:bash
badd +5 term://~/my_git/vue-source-editor-sample//19061:bash
badd +5 term://~/my_git/vue-source-editor-sample//19068:bash
badd +0 ~/my_git/vue-source-editor-sample/public/vue-sample/src/index.js
badd +86 term://~/my_git/vue-source-editor-sample//19119:bash
badd +86 term://~/my_git/vue-source-editor-sample//20572:bash
badd +32 term://~/my_git/vue-source-editor-sample//21260:bash
badd +1 public/vue-sample/dist/demo.html
badd +153 public/vue-sample/dist/comp.umd.js
badd +102 public/vue-sample/dist/comp.common.js
badd +9 public/vue-sample/public/index.html
badd +9 public/index.html
badd +9 term://~/my_git/vue-source-editor-sample//22126:bash
argglobal
%argdel
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
exe 'vert 2resize ' . ((&columns * 56 + 88) / 176)
exe 'vert 3resize ' . ((&columns * 87 + 88) / 176)
argglobal
enew
file NERD_tree_1
balt src/sfc-utils.js
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
let s:l = 55 - ((17 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 55
normal! 025|
wincmd w
argglobal
if bufexists(fnamemodify("src/sfc-utils.js", ":p")) | buffer src/sfc-utils.js | else | edit src/sfc-utils.js | endif
if &buftype ==# 'terminal'
  silent file src/sfc-utils.js
endif
balt term://~/my_git/vue-source-editor-sample//22126:bash
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
let s:l = 13 - ((12 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 13
normal! 03|
wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 88) / 176)
exe 'vert 2resize ' . ((&columns * 56 + 88) / 176)
exe 'vert 3resize ' . ((&columns * 87 + 88) / 176)
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
