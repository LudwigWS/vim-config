" colorscheme hybrid
" colorscheme solarized8
" set background=light
" #############################
" EasyAlign
"
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:easy_align_delimiters = { 
\ ',': { 'pattern': ',', 'ignore_groups': [] },
\ '"': { 'pattern': '"', 'ignore_groups': [] },
\ "'": { 'pattern': "'", 'ignore_groups': [] },
\ ')': { 'pattern': ')', 'ignore_groups': [] },
\ '`': { 'pattern': '`', 'ignore_groups': [] }
\ }

" #############################
"
set number
set relativenumber
set wrap
" Doesn't work
set nospell
" #############################
"
" placeholder
" map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd InsertLeave * exec "silent exec '!im-select com.apple.keylayout.US'"
" packadd! matchit
" let loaded_matchit = 1
" set packpath+=/usr/local/Cellar/neovim/HEAD-90e44ec/share/nvim/runtime/macros
"
" Markdown
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {}
    \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

function! Rename()
    " 参考文章：https://www.jianshu.com/p/d9887b2bf894
    " 将首字母切换为小写
    :%s/_\(\w\)/\u\1/g
    " 将首字母大写的切换成小写
    :%s/^\(\w\)/\L\1/g
endfunction
command! Rename call Rename()

function! Mapper()
    :%s/,/,\r/g
    :g/^$/d
    :%s/^\s*//g
    :v/,/norm A,
    while match(readfile(expand("%:p")),",")!=-1
        :normal gg
        :normal ye
        :let tmp = @0
        " 可用echo tmp 测试
        :normal dd
        :normal G
        :let template1 = "<if test=\"" . tmp .  " != null\">\n\t" . tmp . "\n</if>"
        " execute "normal i" . template1
        put =template1
        :w!
    endwhile
    " 使用g命令先匹配行，然后执行s命令。实现条件替换
    :g/if/norm :s/_\(\w\)/\u\1/g
    :g/if/norm :s/^\(\w\)/\L\1/g
    :v/if/norm A,
endfunction

function! Java2sql()
    :set smartcase
    :%s/\([^ .*+-]\)\([A-Z].\)/\1_\2/g
    "ggguG
    :norm ggguG
endfunction
command! Java2sql call Java2sql()
