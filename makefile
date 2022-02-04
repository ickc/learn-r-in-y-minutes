P ?= $(shell nproc)

# equiv. to Rscript -e 'styler::style_dir()' but faster
format:
	find . \! -path '*/.ipynb_checkpoints/*' -iname '*.r' -print0 | xargs -I '{}' -0 -n 1 -P $(P) Rscript -e 'styler::style_file("{}")'  
	find . \! -path '*/.ipynb_checkpoints/*' -iname '*.r' -exec jupytext --sync {} +

print-%:
	$(info $* = $($*))
