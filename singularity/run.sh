#!/usr/bin/env bash

IMG=./rstudio_server_verse_4.4.1.sif

if [[ ! -e ${IMG} ]]; then
   >&2 echo ${IMG} not found
   exit 1
fi

if [[ ! -e ${HOME}/rstudio ]]; then
   mkdir ${HOME}/rstudio
fi

if [[ ! -e ${HOME}/rstudio/.Rprofile ]]; then
   echo -e '.libPaths("/home/rstudio")' > ${HOME}/rstudio/.Rprofile
else
   if grep -q '.libPaths("/home/rstudio")' ${HOME}/rstudio/.Rprofile; then
      >&2 echo .libPaths already set
   else
      echo -e '.libPaths("/home/rstudio")' >> ${HOME}/rstudio/.Rprofile
   fi
fi

if (( $# == 0 )); then
   singularity run --bind ${HOME}/rstudio:/home/rstudio ${IMG}
else
   singularity run --bind ${HOME}/rstudio:/home/rstudio,$1 ${IMG}
fi

