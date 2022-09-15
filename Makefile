MKD=$(wildcard *.mkd)
TEX=$(MKD:.mkd=.tex)
PDF=$(wildcard figures/*.pdf)

.SUFFIXES: .mkd .tex


lphys2114.pdf: lphys2114.tex $(TEX) $(PDF)
	latexmk -pdf lphys2114.tex

handouts: lphys2114.tex $(TEX) $(PDF)
	pdflatex -jobname lphys2114_handouts -pdf "\PassOptionsToClass{handout}{mc}\input{lphys2114.tex}"

.mkd.tex:
	@echo processing $< to $@
	pandoc --natbib $< -o $@

.PHONY:
bibtex:
	bibtex lphys2114

figures_handrown:
	sh update_handrown_figures.sh
   
