#!/usr/bin/env bash

# Create and use a temp directory in ${HOME} instead
if [[ ! -d ${HOME}/tmp ]]; then
   mkdir ${HOME}/tmp
fi
export TMPDIR=$HOME/tmp

R_VERSION=$(cat ./dockerfile | grep "rocker/verse" | cut -f2 -d':')
if [[ -z ${R_VERSION} ]]; then
   echo Could not get R version
   exit 1
fi

docker build -t rstudio_server_verse_${R_VERSION} .
