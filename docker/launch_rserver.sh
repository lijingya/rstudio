#!/usr/bin/env bash

set -euo pipefail

# -d for create a directory and not a file
# -p interpret TEMPLATE relative to DIR
RSTUDIO_TEMP=$(mktemp -d -p /tmp)
trap "{ rm -rf $RSTUDIO_TEMP; }" EXIT

cat <<__DBCONF__ > $RSTUDIO_TEMP/dbconf
provider=sqlite
directory=$RSTUDIO_TEMP/db.sqlite3
__DBCONF__

export RSTUDIO_PASSWORD=password
export RSTUDIO_PORT=8888


# if [[ $# > 0 ]]; then
#    export RSTUDIO_PORT=$1
#    if [[ ! ${RSTUDIO_PORT} =~ ^[1-9][0-9]+$ ]]; then
#       >&2 echo ${RSTUDIO_PORT} is not a valid port
#       exit 1
#    fi
# fi

printf "RStudio Username:\t$USER\n"
printf "RStudio Password:\t$RSTUDIO_PASSWORD\n"
printf "Port:\t\t\t$RSTUDIO_PORT\n"

if [[ "$1" == "shiny" ]]; then
  R -e "shiny::runApp('/srv/shiny-server/myapp', host='0.0.0.0', port=3838)"
elif [[ "$1" == "rserver" ]]; then
  /usr/lib/rstudio-server/bin/rserver \
	--server-working-dir $RSTUDIO_TEMP \
	--server-data-dir $RSTUDIO_TEMP \
	--database-config-file $RSTUDIO_TEMP/dbconf \
	--server-user=$USER \
	--www-port=$RSTUDIO_PORT \
	--auth-none 0 \
	--auth-pam-helper rstudio_auth

elif [[ "$1" == "both" ]]; then
  /usr/lib/rstudio-server/bin/rserver \
	--server-working-dir $RSTUDIO_TEMP \
	--server-data-dir $RSTUDIO_TEMP \
	--database-config-file $RSTUDIO_TEMP/dbconf \
	--server-user=$USER \
	--www-port=$RSTUDIO_PORT \
	--auth-none 0 \
	--auth-pam-helper rstudio_auth &
  R -e "shiny::runApp('/srv/shiny-server/myapp', host='0.0.0.0', port=3838)" &
  wait
else
  exec "$@"
fi
