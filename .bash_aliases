alias gittag='git log --tags --simplify-by-decoration --pretty="format:%ai %d"'

alias ip='ip -c'

alias cd..='cd ../..'
alias cd...='cd ../../..'
alias cd....='cd ../../../..'
alias cd.....='cd ../../../../..'

blink() {
    printf '\x1b[7mblink\n'
}

oasedit() {
    docker run -d -p 80:8080 swaggerapi/swagger-editor
}

# alias like functions
avim() { nvim --cmd 'let g:lsp_support="ale"' "$@" ;}

yvim() { nvim --cmd 'let g:lsp_support="ycm"' "$@" ;}

cvim() { nvim --cmd 'let g:lsp_support="coc"' "$@" ;}

mvim() { nvim --cmd 'let g:lsp_support="ncm2"' "$@" ;}
