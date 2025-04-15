#!/usr/bin/env bash


# Get the first argument as 'mode'
password="$1"
# Shift off the first argument so "$@" now contains only the mounts
shift

# Join remaining arguments (mounts) into a comma-separated string
# mounts="$*"
# mount_args=""
# for mount in "$@"; do
#   mount_args="$mount_args -v $mount"
# done



IMG=rstudio_server_verse_4.4.3
if ! docker image inspect "$IMG" > /dev/null 2>&1; then
    echo "Docker image '$IMG' does NOT exist."
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

docker run \
   -p 127.0.0.1:8787:8787 -p 127.0.0.1:3838:3838 \
   -e PASSWORD=${password} \
   -d --rm -v ${HOME}/rstudio:/home/rstudio -v ${HOME}:${HOME} ${IMG}

