" visionOS.vim - A gVim color scheme inspired by Catppuccin Mocha
" Maintainer: Romanhan
" Last Change: 2025-08-08
" Adapted for terminal opacity and readability

" Clear existing highlights
set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif

" Set color scheme name
let g:colors_name = "visionOS"

" Catppuccin Mocha color palette - brightened for terminal opacity
" Base colors
hi Normal guifg=#FFFFFF guibg=NONE
hi Comment guifg=#9399b2
hi Keyword guifg=#cba6f7
hi String guifg=#a6e3a1
hi Function guifg=#89b4fa
hi Identifier guifg=#94e2d5
hi Error guifg=#f38ba8 guibg=NONE
hi Warning guifg=#fab387 guibg=NONE

" Additional highlight groups for completeness
hi Constant guifg=#fab387
hi Statement guifg=#cba6f7
hi PreProc guifg=#f5c2e7
hi Type guifg=#94e2d5
hi Special guifg=#fab387
hi Underlined guifg=#74c7ec gui=underline
hi Todo guifg=#1e1e2e guibg=#f9e2af
hi Cursor guifg=#1e1e2e guibg=#FFFFFF
hi LineNr guifg=#9399b2 ctermfg=103
hi CursorLine cterm=NONE gui=NONE guibg=NONE
hi CursorLineNr term=NONE cterm=NONE gui=NONE ctermfg=255 guifg=#FFFFFF
hi Visual guibg=#585b70
hi Search guifg=#1e1e2e guibg=#f9e2af
hi IncSearch guifg=#1e1e2e guibg=#f38ba8
hi Pmenu guifg=#FFFFFF guibg=#45475a
hi PmenuSel guifg=#1e1e2e guibg=#89b4fa
hi PmenuSbar guibg=#585b70
hi PmenuThumb guifg=#9399b2

" Additional syntax highlighting
hi Number guifg=#fab387
hi Boolean guifg=#fab387
hi Float guifg=#fab387
hi Conditional guifg=#cba6f7
hi Repeat guifg=#cba6f7
hi Label guifg=#89b4fa
hi Operator guifg=#89dceb
hi Exception guifg=#f38ba8
hi Include guifg=#f5c2e7
hi Define guifg=#f5c2e7
hi Macro guifg=#f5c2e7
hi StorageClass guifg=#f9e2af
hi Structure guifg=#f9e2af
hi Typedef guifg=#f9e2af

" Diff colors
hi DiffAdd guifg=#a6e3a1 guibg=NONE
hi DiffChange guifg=#f9e2af guibg=NONE
hi DiffDelete guifg=#f38ba8 guibg=NONE
hi DiffText guifg=#89b4fa guibg=NONE

" Git colors (for gitgutter, etc.)
hi GitGutterAdd guifg=#a6e3a1
hi GitGutterChange guifg=#f9e2af
hi GitGutterDelete guifg=#f38ba8

" Status line
hi StatusLine guifg=#FFFFFF guibg=#45475a
hi StatusLineNC guifg=#9399b2 guibg=#313244

" Tab line
hi TabLine guifg=#9399b2 guibg=#313244
hi TabLineFill guifg=#9399b2 guibg=#1e1e2e
hi TabLineSel guifg=#FFFFFF guibg=#45475a

" Fold colors
hi Folded guifg=#9399b2 guibg=#45475a
hi FoldColumn guifg=#9399b2 guibg=NONE

" Matching parentheses
hi MatchParen guifg=#f5c2e7 guibg=#585b70

" Spelling
hi SpellBad guifg=#f38ba8 gui=undercurl guisp=#f38ba8
hi SpellCap guifg=#f9e2af gui=undercurl guisp=#f9e2af
hi SpellLocal guifg=#89b4fa gui=undercurl guisp=#89b4fa
hi SpellRare guifg=#94e2d5 gui=undercurl guisp=#94e2d5
