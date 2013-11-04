" Gvim默认设置
	set nocompatible
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin
	
	set diffexpr=MyDiff()
	function MyDiff()
	  let opt = '-a --binary '
	  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	  let arg1 = v:fname_in
	  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	  let arg2 = v:fname_new
	  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	  let arg3 = v:fname_out
	  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	  let eq = ''
	  if $VIMRUNTIME =~ ' '
	    if &sh =~ '\<cmd'
	      let cmd = '""' . $VIMRUNTIME . '\diff"'
	      let eq = '"'
	    else
	      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
	    endif
	  else
	    let cmd = $VIMRUNTIME . '\diff'
	  endif
	  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
	endfunction
" set nocompatible        " Must be first line
" 判断操作系统类型
	if(has("win32") || has("win64"))
	    let g:isWIN = 1
	else
	    let g:isWIN = 0
	endif
	if !(has('win16') || has('win32') || has('win64'))
	    set shell=/bin/sh
	endif	
" 判断是否处于GUI界面
	if has("gui_running")
	    let g:isGUI = 1
	else
	    let g:isGUI = 0
	endif
" 设置文件编码和文件格式
	set fenc=utf-8
	set encoding=utf-8
	set fileencodings=utf-8,gbk,cp936,latin-1
	set fileformat=unix
	set fileformats=unix,dos,mac
	if g:isWIN
	    source $VIMRUNTIME/delmenu.vim
	    source $VIMRUNTIME/menu.vim
	    language messages zh_CN.utf-8
	endif
	        
" Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after
        endif
    " }

" 使用GUI界面时的设置
	if g:isGUI
	    " 启动时自动最大化窗口
	    if g:isWIN
	        au GUIEnter * simalt ~x
	    endif
	   "winpos 20 20				" 指定窗口出现的位置，坐标原点在屏幕左上角
	   "set lines=20 columns=90		" 指定窗口大小，lines为高度，columns为宽度
	    set guioptions+=c			" 使用字符提示框
	    "set guioptions-=m			" 隐藏菜单栏
	    set guioptions-=T			" 隐藏工具栏
	    set guioptions-=L			" 隐藏左侧滚动条
	   "set guioptions-=r			" 隐藏右侧滚动条
	    set guioptions-=b			" 隐藏底部滚动条
	   "set showtabline=0			" 隐藏Tab栏
	    set cursorline				" 突出显示当前行
	endif
" Setup Bundle Support {
        " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype off
        if g:isGUI
			set rtp+=$Vim/vimfiles/bundle/vundle/ 	" 此处制定windows下Vundle的路径
		else
			set rtp+=~/.vim/bundle/vundle/		" linux下Vundle路径
		endif
		call vundle#rc('$Vim/vimfiles/bundle/')
    " }
" My bundle:
    "	Bundle 'Markdown'
	"	Markdown插件需要手动放在vimfiles下面,不明觉厉
	Bundle 'gmarik/vundle'	
		"这个是必须的
	Bundle 'taglist.vim'
	Bundle 'SuperTab'
	Bundle 'vimwiki'
	Bundle 'winmanager'
	    let g:winManagerWindowLayout='FileExplorer|TagList'
	    nmap wm :WMToggle<cr>
	    map <silent> <F9> :WMToggle<cr>
	Bundle 'The-NERD-tree'              
	    " 提供展示文件/目录列表的功能，比自带的文件浏览器要好很多
	Bundle 'snipMate'
	     let g:snippets_dir = "$vim/vimfiles/snippets/"
	Bundle 'CmdlineComplete'
	    " 提供命令模式下的补全，可以补全缓冲区中出现过的单词，很好用"
	Bundle 'AutoComplPop'
	    " Acp, 自动补全插件, 可回车选取第一个匹配
	Bundle 'yueyoum/vim-linemovement'
	    " 可以上下移动行
	Bundle 'terryma/vim-multiple-cursors'
	Bundle 'colorselector'
	Bundle 'surround.vim'
	Bundle 'bling/vim-airline'
	"Bundle 'The-NERD-Commenter'
	Bundle 'ctrlp.vim'
	    "模糊查询定位：
	Bundle 'Solarized'
		" 养眼主题

" 全局配置
	set tabstop=4 
	set	shiftwidth=4
	set nobackup					" 不创建备份
	set smartcase					" 智能大小写,在搜索关键字中如有一个大写字母则敏感大小写
	set autoindent					" 自动缩进
	set ignorecase					" 忽略大小写(搜索有用)
	set ruler						" 显示标尺
	set showcmd						" 输入的命令显示出来，看的清楚些
	set laststatus=2				" 启动显示状态行(1),总是显示状态行(2)
	set nocompatible				" 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
	set showtabline=2				" 总是显示标签栏
	set number
	set smarttab
	set hlsearch					" 高亮搜索
	set relativenumber				" 开启相对行号
	set cursorline					" 突出显示当前行
	"map <F3> :NERDTree<CR>			" F3打开目录树
	set completeopt=preview,menu	" 代码补全
	filetype plugin on				" 允许插件
	 set clipboard+=unnamed			" 共享剪贴板
	 set mouse=a                    " 启用鼠标
	"set cul						" 高亮光标所在行,自带
	"set cuc						" 高亮光标所在列
	 set incsearch					" 开启实时搜索功能
	"set list						" 显示特殊字符，其中Tab使用高亮竖线代替，尾部空白使用高亮点号代替
     "set listchars=tab:\┊\ ,trail:.
	 set confirm                    " 在处理未保存或只读文件的时候，弹出确认
	 set autoread					" 设置当文件被改动时自动载入
	 syntax enable					" 语法高亮
	 filetype on                    " 侦测文件类型
	 filetype indent on                     
	 filetype plugin on				" 针对不同的文件类型加载对应的插件
	nmap <F12> :tabnew<CR>			" 快速隐藏当前窗口内容
	imap <F12> <ESC>:tabnew<CR>
	vmap <F12> <ESC>:tabnew<CR>

" 设置主题,代码配色方案
	colorscheme solarized			" Gvim配色方案
	set guifont=Consolas:h11		" 设置字体
	set completeopt=longest,menu	" 打开文件类型检测, 加了这句才可以用智能补全
	set completeopt=preview,menu	" 代码补全	
	
" 显示中文帮助
	if version >= 603
		set helplang=cn
		set encoding=utf-8
	endif

" ======= 编译 && 运行 && 模板 ======= "
	" 编译并运行
	func! Compile_Run_Code()
	    exec "w"
	    if &filetype == "c"
	        if g:isWIN
	            exec "!gcc -Wall -std=c11 -o %:r %:t && %:r.exe"
	        else
	            exec "!gcc -Wall -std=c11 -o %:r %:t && ./%:r"
	        endif
	    elseif &filetype == "cpp"
	        if g:isWIN
	            exec "!g++ -Wall -std=c++11 -o %:r %:t && %:r.exe"
	        else
	            exec "!g++ -Wall -std=c++11 -o %:r %:t && ./%:r"
	        endif
	    elseif &filetype == "go"
	        if g:isWIN
	            exec "!go build %:t && %:r.exe"
	        else
	            exec "!go build %:t && ./%:r"
	        endif
	    elseif &filetype == "scala"
	        exec "!scala %:t"
	    elseif &filetype == "php"
	        exec "!php %:t"
	    elseif &filetype == "python"
	        exec "!python %:t"
	    elseif &filetype == "ruby"
	        exec "!ruby -w %:t"
	    elseif &filetype == "coffee"
	        exec "!coffee %:t"
	    elseif &filetype == "javascript"
	        exec "!node %:t"
	    elseif &filetype == "sh"
	        exec "!bash %:t"
	endif
	endfunc
	
" 新文件标题
	"新建.c,.h,.sh,.java文件，自动插入文件头
	autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py exec ":call SetTitle()"
	""定义函数SetTitle，自动插入文件头
	func SetTitle()
	    "如果文件类型为.sh文件
	    if &filetype == 'sh'
	        call setline(1,"\#!/bin/bash")
	        call append(line("."), "")
	    elseif &filetype == 'python'
	        call setline(1,"#!/usr/bin/env python")
	        call append(line("."),"# coding=utf-8")
	        call append(line(".")+1, "")
	    elseif &filetype == 'md'
	        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
	    else
	        call setline(1, "/*************************************************************************")
	        call append(line("."), "    > File Name: ".expand("%"))
	        call append(line(".")+1, "    > Author: Mike")
	        call append(line(".")+2, "    > Mail: regweb@126.com ")
	        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
	        call append(line(".")+4, " ************************************************************************/")
	        call append(line(".")+5, "")
	    endif
	    if &filetype == 'cpp'
	        call append(line(".")+6, "#include<iostream>")
	        call append(line(".")+7, "using namespace std;")
	        call append(line(".")+8, "")
	    endif
	    if &filetype == 'c'
	        call append(line(".")+6, "#include<stdio.h>")
	        call append(line(".")+7, "")
	    endif
	endfunc

"python 调试快捷键
	map <leader>py :!python.exe %<cr>

	filetype plugin indent on              "  针对不同的文件类型采用不同的缩进格式,这2行最好放在配置文件最后
	syntax on                              " 开启文件类型侦测,这2行最好放在配置文件最后
