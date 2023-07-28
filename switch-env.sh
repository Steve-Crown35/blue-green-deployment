#!/usr/bin/env bash 

blue="/etc/nginx/sites-enabled/blue.conf"
green="/etc/nginx/sites-enabled/green.conf"

# Functions
reloadNginx (){
  systemctl reload nginx
}

switchTogreen () {
  echo "Switching to: green"
  rm -rf $blue
  ln -s /etc/nginx/sites-available/green.conf $green
  reloadNginx
  exit 0
}

switchToblue () {
  echo "Switching to: blue"
  rm -rf $green
  ln -s /etc/nginx/sites-available/blue.conf $blue
  reloadNginx
  exit 0
}

CheckActiveEnvironment () {
  if [ -L $blue ]; then
    echo "ActiveEnvironment:blue"
    switchTogreen
  
  elif [ -L $green ]; then
    echo "ActiveEnvironment:green"
    switchToblue
  else
    echo "No active Environment!"
    switchToblue
  fi
}

# Take some action
CheckActiveEnvironment