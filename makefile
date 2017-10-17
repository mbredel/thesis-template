
VERSION = v4.4
NAME    = Max
SURNAME = Mustermann

all: clean
	pdflatex thesis.tex
	bibtex thesis
	pdflatex thesis.tex
	pdflatex thesis.tex

clean:
	@rm -rf *run.xml *-blx.bib *.aux *.bbl *.blg *.brf *.log *.lof *.lot *.lol *.out *.tcp *.toc *.tps *.bak *.backup *.*~
	@for i in run.xml -blx.bib aux bbl blg brf log lof lot lol out tcp toc tps bak backup ; do find -name *.$$i -exec rm {} + ; done
	@find -name *.*~ -exec rm {} +

cleanall: clean
	@rm *.pdf

bz2: clean
	@echo 'creating package including Docs'
	@tar --exclude-vcs -cf `pwd`/../thesis-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`.tar `pwd`/../`pwd | sed "s,^\(.*/\)\?\([^/]*\),\2,"`
	@bzip2 `pwd`/../thesis-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`.tar

bz2-small: clean
	@echo 'creating package excluding Docs'
	@tar --exclude-vcs --exclude=Docs -cf `pwd`/../thesis-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`_small.tar `pwd`/../`pwd | sed "s,^\(.*/\)\?\([^/]*\),\2,"`
	@bzip2 `pwd`/../thesis-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`_small.tar
