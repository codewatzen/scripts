#!/bin/bash

ipsallowed="/home/{username}/ipsallowed"
machineTSIP=$(tailscale ip -4)
tailscalemachines=$(tailscale status | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | grep v "${machineTSIP}")
for ip in $tailscalemachines; do {
    if grep -Fxq "$ip" $ipsallowed
        then 
          echo "$ip is already in file"
        else
          echo "$ip" >> $ipsallowed
    fi
}
done

for x in $(cat $ipsallowed); do {
sudo ufw allow from "$x"
}
done
sudo ufw reload > /dev/null
