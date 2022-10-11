MKD=$(wildcard *.mkd)
XP=$(wildcard Figures/*.xp)
TEX=$(MKD:.mkd=.tex)
EEPIC=$(XP:.xp=.eepic)
#PDF=$(wildcard figures/*.pdf)

.SUFFIXES: .mkd .tex .eepic .xp


lphys2114.pdf: lphys2114.tex $(TEX) $(PDF) $(EEPIC)
	latexmk -pdf lphys2114.tex

handouts: lphys2114.tex $(TEX) $(PDF)
	pdflatex -jobname lphys2114_handouts -pdf "\PassOptionsToClass{handout}{mc}\input{lphys2114.tex}"

.mkd.tex:
	@echo processing $< to $@
	pandoc --natbib $< -o $@

.xp.eepic:
	@echo processing $< to $@
	cd Figures; epix `basename $<` ; cd ..


.PHONY:
bibtex:
	bibtex lphys2114

figures_handrown:
	sh update_handrown_figures.sh
   
