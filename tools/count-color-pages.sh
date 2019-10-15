#!/bin/bash

if [ -z "$1" ]
then
    file=master-thesis.pdf
    echo "No argument supplied. Using 'master-thesis.pdf' as default value"
else
    file="$1"
fi

colored_pages=$(gs -o - -sDEVICE=inkcov $file | grep -v "^ 0.00000  0.00000  0.00000" | grep "^ " | wc -l)
total_pages=$(pdfinfo $file | grep Pages | awk '{print $2}')

black_pages=$((total_pages-colored_pages))

echo -e "Color Pages:\t$colored_pages"
echo -e "Black Pages:\t$black_pages"
echo -e "Total Pages:\t$total_pages"
