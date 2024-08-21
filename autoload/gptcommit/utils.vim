let s:scriptname = expand('<sfile>:p')
let s:scripthome = fnamemodify(s:scriptname, ':h')

function! gptcommit#utils#generate()
	let base = fnamemodify(s:scripthome, ':h:h')
	let script = printf('%s/bin/%s', base, 'prepare-commit-msg')
	let commit_msg = system(script)
	let content = split(commit_msg, "\n")
	call append(line('.') - 1, content)
	echohl Title
	echo "Commit message generated"
	echohl None
	redraw
endfunc
