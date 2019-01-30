"gvim only
"put in ~/.vim/after/syntax/python/greymagic.vim
syntax match HeadIndent1 "\(    \)\@<=    " display
hi HeadIndent1 gui=none guibg=grey4
syntax match HeadIndent2 "\(        \)\@<=    " display
hi HeadIndent2 gui=none guibg=grey6
syntax match HeadIndent3 "\(        \)\@<=    " display
hi HeadIndent3 gui=none guibg=grey8
syntax match HeadIndent4 "\(            \)\@<=    " display
hi HeadIndent4 gui=none guibg=grey10
syntax match HeadIndent5 "\(                \)\@<=    " display
hi HeadIndent5 gui=none guibg=grey12
syntax match HeadIndent6 "\(                    \)\@<=    " display
hi HeadIndent6 gui=none guibg=grey14
syntax match HeadIndent7 "\(                        \)\@<=    " display
hi HeadIndent7 gui=none guibg=grey16
syntax match HeadIndent8 "\(                            \)\@<=    " display
hi HeadIndent8 gui=none guibg=grey18
syntax match HeadIndent9 "\(                                \)\@<=    " display
hi HeadIndent9 gui=none guibg=grey20

