MDDIR=Md/
MKDFILES=$(wildcard  $(MDDIR)*.mkd)
TEXDIR=./
TEX = $(patsubst $(MDDIR)%.mkd,%.tex,$(MKDFILES))
XP=$(wildcard Figures/*.xp)
IPYNB=$(wildcard Jupyter/*.ipynb)
TIKZ=$(wildcard Figures/*.tikz)
EEPIC=$(XP:.xp=.eepic)
JUPYTERTEX=$(IPYNB:.ipynb=.tex)
#PDF=$(wildcard figures/*.pdf)

.SUFFIXES: .mkd .tex .eepic .xp .ipynb


lphys2114.pdf: lphys2114.tex $(TEX) $(PDF) $(EEPIC) $(JUPYTERTEX) mc.cls $(TIKZ)
	@echo check mdfiles: $(MKDFILES)
	@echo check texfiles: $(TEX)
	sh Makeversion.sh &&  latexmk -pdf lphys2114.tex

local.bib: lphys2114.aux
	~/Unix/BibManagement/generate_s_bibtex.py `cat lphys2114.aux| ~/bin/citation_extract.pl`  > local.bib

handouts: lphys2114.tex $(TEX) $(PDF)
	pdflatex -jobname lphys2114_handouts -pdf "\PassOptionsToClass{handout}{mc}\input{lphys2114.tex}"

%.tex:  Md/%.mkd
	@echo processing $< to $@
	pandoc --natbib $< -f markdown  -o $@; sed -i '1 i\%\n% AUTOMATICALLY GENERATED  WITH PANDOC DO NOT EDIT\n%' $@ 

$(wildcard Figures/circle_map_*.eepic): Figures/circle_map_base.cpp

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
lphys2114-figures.tex:
	touch lphys2114-figures

bibtex:
	bibtex lphys2114

figures_handrown:
	sh update_handrown_figures.sh
   
upload: lphys2114.pdf lphys2114_corrections.pdf
	scp lphys2114.pdf aurora:/elic/web/crucifix/direct
# scp lphys2114_corrections.pdf aurora:/elic/web/crucifix/direct
	
