FROM ubuntu:16.04

MAINTAINER mbredel "https://github.com/mbredel"

# Install packages for building the LaTeX template.
RUN apt-get -qq update && apt-get install -y --no-install-recommends \
    make \
    apt-utils \
    ghostscript \
    texlive \
    texlive-bibtex-extra \
    texlive-fonts-extra \
    texlive-lang-english \
    texlive-lang-german \
    texlive-latex-extra \
    texlive-math-extra \
    texlive-publishers \
    texlive-science \
    chktex

# Command to actually build the LaTeX code.
CMD ["make", "--directory", "/thesis-template/", "publish"]
