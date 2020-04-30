let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
let s:swcolors = map(paths, 'fnamemodify(v:val, ":t:r")')
let s:swcolors = sort(s:swcolors)
"echo s:swcolors
"let s:swindex = -1

function! SwitchColor(swinc)
	"let s:swindex = s:swindex + a:swinc
	if exists('g:colors_name')
		let color = g:colors_name
		let s:swindex = index(s:swcolors, g:colors_name)
		let e = "existeix"
	else
		let color = "default"
		let s:swindex = -1
		let e = "no existeix"
	endif
	let s:swindex1 = s:swindex + a:swinc
	let i = s:swindex1 % len(s:swcolors)
	execute "colorscheme " . s:swcolors[i]

	redraw!
	echo "colors[" . s:swindex . "] = " . color . " - " . s:swindex1 . " colors[" . i . "] = " . s:swcolors[i] . " " . e
	"echo s:swindex . " - " . color . " -> " . s:swindex1 . " - " . s:swcolors[i]
	"execute "colorscheme"
	"silent quitall
endfunction

"nnoremap <leader><leader>ñ :call SwitchColor(1)<CR>
"nnoremap <leader><leader>l :call SwitchColor(-1)<CR>

