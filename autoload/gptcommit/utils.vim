let s:scriptname = expand('<sfile>:p')
let s:scripthome = fnamemodify(s:scriptname, ':h')

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

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

function! gptcommit#utils#translate()
	let base = fnamemodify(s:scripthome, ':h:h')
	let script = printf('%s/bin/%s', base, 'translate-commit')
	let text = s:get_visual_selection()
	let translated_text = system(script, text)
	let content = split(translated_text, "\n")
	call append(line('.') - 1, content)
	echohl Title
	echo "Translated"
	echohl None
	redraw
endfunc
