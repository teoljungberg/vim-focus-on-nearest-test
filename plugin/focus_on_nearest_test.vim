function! g:GetTestName()
  let vanilla = line('.')
  let test_name = ""

  while vanilla > 0 && match(getline(vanilla), 'test_') == -1
    let vanilla -= 1
  endwhile

  let dsl = line('.')

  while dsl > 0 && match(getline(dsl), 'test.*do') == -1
    let dsl -= 1
  endwhile

  if dsl == 0 && vanilla == 0
    return 0
  endif

  if vanilla > dsl
    let test_name = substitute(getline(vanilla), '.*def ', "", "")
  else
    let test_name = substitute(substitute(getline(dsl), "test ['\"]", "", ""), "['\"] do", "", "")
    let test_name = substitute(test_name, '^\s*\(.\{-}\)\s*$', '\1', '')
    let test_name = substitute(test_name, ' ', '\\ ', 'g')
  end

  return test_name
endfunction

function! FocusOnNearestTest()
  let base_cmd = ":FocusDispatch "
  let command = ""

  if match(expand("%"), "_test.rb$") != -1
    if filereadable("Gemfile") == 1
      let base_cmd = base_cmd . "bundle exec "
    endif

    let command = base_cmd . "ruby -Ilib:test % -n /" . g:GetTestName() . "/"
  elseif match(expand("%"), "_spec.rb$") != -1
    if filereadable("bin/rspec") == 1
      let base_cmd = base_cmd . "bin/rspec "
    else
      let base_cmd = base_cmd . "bundle exec rspec "
    endif

    let command =  base_cmd . "'%':" . line(".")
  endif

  exec command
endfunction
command! FocusOnNearestTest :call FocusOnNearestTest()
