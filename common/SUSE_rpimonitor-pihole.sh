#!/bin/bash

# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation; either version 2.1 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# Copyright (C) 2018 Malcolm Lewis <malcolmlewis@opensuse.org>

# Description: Script to extract pihole-FTL engine data
# Version: 0.0.1
# Date: 19th September, 2018
# Ref: https://docs.pi-hole.net/ftldns/telnet-api/


MY_DEBUG=0

if (( $# != 1 )); then
	echo "Usage: $0 <stats,top-domains,top-ads,top-clients,recentBlocked>" >&2
	exit 1
fi

PIHOLE_INFO="$1"

ftl_port=$(cat /var/run/pihole-FTL.port 2> /dev/null)
   if [[ -n "$ftl_port" ]]; then
      # Open connection to FTL engine
      exec 3<>"/dev/tcp/127.0.0.1/$ftl_port"
      # Test if connection is open
      if { "true" >&3; } 2> /dev/null; then
      # Send command to FTL
         echo -e ">$PIHOLE_INFO" >&3
         # Read input
         read -r -t 1 LINE <&3
         until [[ ! $? ]] || [[ "$LINE" == *"EOM"* ]]; do
            echo "$LINE" >&1
            read -r -t 1 LINE <&3
         done
         # Close connection
         exec 3>&-
         exec 3<&-
      fi
      else
         echo "No data, pihole-FTL not running?"
      fi
