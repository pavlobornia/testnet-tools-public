#!/bin/bash
RELEASE_VERSION='v2.5.1'

function setupVars {
  if [ ! $MESON_TOKEN ]; then
    echo "Token register and Login in https://meson.network"
    read -p "Enter token: " MESON_TOKEN
  fi

  if [ ! $MESON_SPACELIMIT ]; then
    echo ""
    df -h /
    echo ""
    echo "Maximum allowable space for Terminal in GB. Less than the total disk. At least 40 GB"
    read -p "Enter spacelimit: " MESON_SPACELIMIT
  fi
}

function installMESON {
  cd /tmp
  wget https://assets.meson.network:10443/static/terminal/${RELEASE_VERSION}/meson-linux-amd64.tar.gz > /dev/null 2>&1
  tar -zxf meson-linux-amd64.tar.gz*
  sudo mv meson-linux-amd64 /opt/meson
  rm -rf meson-linux-amd64.tar.gz

  sudo echo "token = $MESON_TOKEN
  port = 19091
  spacelimit = $MESON_SPACELIMIT
  " > /opt/meson/config.txt

  sudo /opt/meson/meson service-install
  sudo /opt/meson/meson service-start
  sudo /opt/meson/meson service-status
}

function deleteMESON {
	sudo systemctl disable meson
	sudo systemctl stop meson
	/opt/meson/meson service-remove
}

function configVars {
  sudo echo "token = $MESON_TOKEN
  port = 19091
  spacelimit = $MESON_SPACELIMIT
  " > /opt/meson/config.txt
  sudo systemctl restart meson
}

PS3='Please enter your choice number and press enter): '
options=("Install" "ResetConfig" "Delete" "Quit")
select opt in "${options[@]}"
do
  case $opt in
      "Install")
        echo -e '\n\e[42mYou choose install...\e[0m\n' && sleep 1
        setupVars
        installMESON
        echo -e '\n\e[42mMeson miner was installed!\e[0m\n' && sleep 1
        break
        ;;
      "ResetConfig")
        echo -e '\n\e[42mPlease set new config parameters...\e[0m\n' && sleep 1
        setupVars
        configVars
        echo -e '\n\e[42mMeson config was reset!\e[0m\n' && sleep 1
        break
        ;;
      "Delete")
        echo -e '\n\e[31mYou choose delete...\e[0m\n' && sleep 1
        deleteMESON
        echo -e '\n\e[42mMeson miner was deleted!\e[0m\n' && sleep 1
        break
        ;;
      "Quit")
        break
        ;;
      *) echo -e "\e[91minvalid option $REPLY\e[0m";;
  esac
done
