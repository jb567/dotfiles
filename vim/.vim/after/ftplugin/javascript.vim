setlocal path=.,,
setlocal suffixesadd+=.js,.jsx
setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)

let b:undo_ftplugin .= '| setlocal path< suffixesadd< include<'
