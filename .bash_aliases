alias gittag='git log --tags --simplify-by-decoration --pretty="format:%ai %d"'

alias cd..='cd ../..'
alias cd...='cd ../../..'
alias cd....='cd ../../../..'
alias cd.....='cd ../../../../..'

# alias like functions
avim() { nvim --cmd 'let g:lsp_support="ale"' "$@" ;}

cvim() { nvim --cmd 'let g:lsp_support="coc"' "$@" ;}
