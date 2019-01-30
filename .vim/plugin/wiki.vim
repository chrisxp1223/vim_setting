function! WikiDeploy()
  let origFileName = expand("%")
  "let destFileName = expand("%:p:h") . '/' . strpart(expand("%:p:t"), 0, strridx(expand("%:p:t"),".") ) . '.html'
  let destFileName = '/home/fcwu/Documents/MyWiki/html/' . strpart(expand("%:p:t"), 0, strridx(expand("%:p:t"),".") ) . '.html'
  let cpresult = system('txt2tags -i "' . origFileName . '" -o "' . destFileName . '" -t html --style=css/main_v1.css')
  execute ':echo "' . cpresult . '"'
endfunction


command! -nargs=? WikiDeploy :call WikiDeploy()
