MASTER  = thesis
VERSION = v4.4
NAME    = Max
SURNAME = Mustermann

all: clean
	@pdflatex ${MASTER}.tex
	@test -f ${MASTER}-blx.bib && ( bibtex ${MASTER}; pdflatex ${MASTER}.tex ) || echo "No Bibtex"
	@pdflatex ${MASTER}.tex

publish: all
	@ps2pdf14 -dPDFSETTINGS=/prepress ${MASTER}.pdf
	@mv ${MASTER}.pdf.pdf ${MASTER}.pdf

clean:
	@rm -rf *run.xml *-blx.bib *.aux *.bbl *.blg *.brf *.log *.lof *.lot *.lol *.out *.tcp *.toc *.tps *.bak *.backup *.pdfsync *.synctex.gz *.*~
	@for i in run.xml -blx.bib aux bbl blg brf log lof lot lol out tcp toc tps bak backup pdfsync synctex.gz; do find . -name *.$$i -exec rm -f {} + ; done
	@find . -name *.*~ -exec rm -f {} +

cleanall: clean
	@rm *.pdf

test: clean
	@pdflatex -interaction=nonstopmode -halt-on-error ${MASTER}.tex
	@test -f ${MASTER}-blx.bib && ( bibtex ${MASTER}; pdflatex ${MASTER}.tex ) || echo "No Bibtex" 
	@pdflatex ${MASTER}.tex

bz2: clean
	@echo 'creating package including Docs'
	@tar --exclude-vcs -cf `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`.tar `pwd`/../`pwd | sed "s,^\(.*/\)\?\([^/]*\),\2,"`
	@bzip2 `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`.tar

bz2-small: clean
	@echo 'creating package excluding Docs'
	@tar --exclude-vcs --exclude=Docs -cf `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`_small.tar `pwd`/../`pwd | sed "s,^\(.*/\)\?\([^/]*\),\2,"`
	@bzip2 `pwd`/../${MASTER}-${NAME}_${SURNAME}-${VERSION}-`date +%Y%m%d`_small.tar
