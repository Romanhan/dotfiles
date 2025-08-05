" visionOS.vim - A gVim color scheme inspired by Catppuccin Macchiato
" Maintainer: Romanhan
" Last Change: 2025-07-11

" Clear existing highlights
set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif

" Set color scheme name
let g:colors_name = "visionOS"

" Define GUI colors
hi Normal guifg=#FFFFFF guibg=#4A4A44
hi Comment guifg=#FFFFFF
hi Keyword guifg=#F5BDE6
hi String guifg=#FFFFFF
hi Function guifg=#8BD5CA
hi Identifier guifg=#A6DA95
hi Error guifg=#ED8796 guibg=#4A4A44
hi Warning guifg=#F5A97F guibg=#4A4A44

" Additional highlight groups for completeness
hi Constant guifg=#8BD5CA
hi Statement guifg=#F5BDE6
hi PreProc guifg=#F5BDE6
hi Type guifg=#8BD5CA
hi Special guifg=#F5A97F
hi Underlined guifg=#8AADF4
hi Todo guifg=#FFFFFF guibg=#ED8796
hi Cursor guifg=#4A4A44 guibg=#FFFFFF
hi CursorLine guibg=#5B6078
hi LineNr guifg=#939AB7
hi Visual guibg=#5B6078
hi Search guifg=#FFFFFF guibg=#ED8796
hi Pmenu guifg=#FFFFFF guibg=#494D64
hi PmenuSel guifg=#4A4A44 guibg=#A5ADCB
