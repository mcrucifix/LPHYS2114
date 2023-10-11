MKD=$(wildcard *.mkd)
XP=$(wildcard Figures/*.xp)
IPYNB=$(wildcard Jupyter/*.ipynb)
TIKZ=$(wildcard Figures/*.tikz)
TEX=$(MKD:.mkd=.tex)
EEPIC=$(XP:.xp=.eepic)
JUPYTERTEX=$(IPYNB:.ipynb=.tex)
#PDF=$(wildcard figures/*.pdf)

.SUFFIXES: .mkd .tex .eepic .xp .ipynb


lphys2114.pdf: lphys2114.tex $(TEX) $(PDF) $(EEPIC) $(JUPYTERTEX) mc.cls $(TIKZ)
	sh Makeversion.sh &&  latexmk -pdf lphys2114.tex

handouts: lphys2114.tex $(TEX) $(PDF)
	pdflatex -jobname lphys2114_handouts -pdf "\PassOptionsToClass{handout}{mc}\input{lphys2114.tex}"

.mkd.tex:
	@echo processing $< to $@
	pandoc --natbib $< -o $@; sed -i '1 i\%\n% AUTOMATICALLY GENERATED  WITH PANDOC DO NOT EDIT\n%' $@

.xp.eepic:
	@echo processing $< to $@
	cd Figures; CPLUS_INCLUDE_PATH=. epix `basename $<` ; cd ..

.ipynb.tex:
	@echo processing $< to $@
	cd Jupyter; jupyter-nbconvert --to latex --template mylatex `basename $<` ; cd ..

flattenned.tex: $(TEX) 
	python3 ~/.local/bin/latex-flatten.py lphys2114.tex flattenned.tex

lphys2114_corrections.pdf: flattenned.tex  2023_distr_flattenned.tex
	python3 ~/.local/bin/latex-flatten.py lphys2114.tex flattenned.tex
	latexdiff-vc --force    --packages=hyperref,amsmath  --only-changes --pdf 2023_distr_flattenned.tex flattenned.tex
	mv flattenned-diff.pdf lphys2114_corrections.pdf

.PHONY:
bibtex:
	bibtex lphys2114

figures_handrown:
	sh update_handrown_figures.sh
   
upload: lphys2114.pdf lphys2114_corrections.pdf
	scp lphys2114.pdf aurora:/elic/web/crucifix/direct
	scp lphys2114_corrections.pdf aurora:/elic/web/crucifix/direct
	
