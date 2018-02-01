#!/bin/sh

if [ "$CI_SERVER" != "" ]; then
  # CI environment
  run="$1 $2 '$3'"
  shift 3
#  eval $run
  ncloud-entrypoint.sh
elif [ "$1" != "" ]; then
  # Execute shell command
  exec /home/ncloud/ncloud-entrypoint.sh "run $@"
else
  # Run continuous server

  if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
    ssh-keygen -A
  fi
  
  if [ ! -d "/root/.ssh" ]; then
    if [ -d "/data/.ssh" ]; then
      cp -Ra /data/.ssh /root/.ssh
    fi
  fi
  
  if [ ! -d "/var/run/sshd" ]; then
    mkdir -p /var/run/sshd
  fi

   echo Starting SSH server
   exec /usr/sbin/sshd &
   echo Starting web server
  python3 -m http.server 8000
fi
