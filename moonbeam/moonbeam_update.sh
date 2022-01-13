#!/bin/bash

if [ ! $MOONBEAM_NODENAME ]; then
	read -p "Enter node name: " MOONBEAM_NODENAME
	echo 'export MOONBEAM_NODENAME='${MOONBEAM_NODENAME} >> $HOME/.bash_profile
	. $HOME/.bash_profile
fi

export UID=${UID}
export GID=${GID}

docker-compose down
docker-compose pull
docker-compose up -d
