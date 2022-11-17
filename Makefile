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

.PHONY:
bibtex:
	bibtex lphys2114

figures_handrown:
	sh update_handrown_figures.sh
   
