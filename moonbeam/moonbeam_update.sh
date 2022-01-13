#!/bin/bash
source $HOME/.bash_profile

if [ ! $MOONBEAM_NODENAME ]; then
	read -p "Enter node name: " MOONBEAM_NODENAME
	echo 'export MOONBEAM_NODENAME='${MOONBEAM_NODENAME} >> $HOME/.bash_profile
	source $HOME/.bash_profile
fi

export uid=`id -u`
export gid=`id -g`

docker-compose down
docker-compose pull
docker-compose up -d
