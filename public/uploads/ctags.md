##Sublime Text 2 中 ctags 設定

請參考

https://coderwall.com/p/du_sgq

簡而言之，就是在專案中執行

`ctags -R -f .tags . $(bundle list --paths)`

## cscope 設定

相關指令：

	find . -name "*.rb" > cscope.files
	cscope -q -R -b -i cscope.files 
	cscope -d
	
## ctags & cscope 重要

sublime text 2 中，安裝這二個 plugin 時，要記得更改其 command path，為

`/usr/local/bin/ctags` 

and

`/usr/local/bin/cscope`



