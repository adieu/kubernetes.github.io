#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: build.sh doc.md DOC_TITLE"
    exit 1
fi

IMAGE=adieu/pandoc
DOC_ROOT=$(pwd)/..
NAME=$(basename "$1")
NAME="${NAME%.*}"
ARGS=( "$1" -o $NAME.pdf --toc --listings -H listings-setup.tex --latex-engine=xelatex )
ARGS+=( -f markdown_github --filter pandoc-include --filter ./removetoc.py --filter ./pandoc-svg.py )
ARGS+=( -V documentclass=report -V title="$2" )
docker run --rm \
    -v $DOC_ROOT/_pdf:/source \
    -v $DOC_ROOT/images:/images \
    -v $DOC_ROOT/docs:/docs \
    $IMAGE \
    "${ARGS[@]}"
