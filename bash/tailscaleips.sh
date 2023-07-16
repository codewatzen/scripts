#!/bin/bash

# Define the path for the file that will store allowed IPs
ipsallowed="${HOME}/ipsallowed"

# Get the machine's Tailscale IP address
machineTSIP=$(tailscale ip -4)

# Get a list of all Tailscale machines' IP addresses
# Excluding the machine's own IP from the list
tailscalemachines=$(tailscale status | awk '/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/{print $NF}' | grep -wv "$machineTSIP")

# Loop through the list of Tailscale machines' IP addresses
# and add any new IP to the allowed file
while IFS= read -r ip; do
  # Check if the IP is already in the allowed file
  if ! grep -Fxq "$ip" "$ipsallowed"; then
    # If IP is not in the allowed file, add it
    echo "$ip" >> "$ipsallowed"
  fi
done < <(echo "$tailscalemachines")

# Filter out any comments (lines starting with '#') from the allowed file
# Then loop through the remaining IPs and allow them through the firewall
grep -v '^ *#' < "$ipsallowed" | while IFS= read -r line; do
  sudo ufw allow from "$line"
done

# Reload the firewall rules to apply the changes
sudo ufw reload >/dev/null
