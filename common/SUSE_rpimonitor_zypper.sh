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
# Copyright (C) 2017-2018 Malcolm Lewis <malcolmlewis@opensuse.org>

MY_DEBUG=0
if [ $MY_DEBUG == 1 ]; then
   echo "DEBUG ON - Starting zypper run"
fi

MY_PACKAGES=$(/usr/bin/awk "BEGIN {print `/usr/bin/zypper -q --no-refresh se -i -t package | /usr/bin/wc -l` - 3}")
MY_PATTERNS=$(/usr/bin/awk "BEGIN {print `/usr/bin/zypper -q --no-refresh se -i -t pattern | /usr/bin/wc -l` - 3}")
MY_PATCHES=$(/usr/bin/awk "BEGIN {print `/usr/bin/zypper -q --no-refresh se -i -t patch | /usr/bin/wc -l` -3}")
MY_INSTALLED=$(/usr/bin/awk "BEGIN {print `/usr/bin/zypper -q --no-refresh se -i | /usr/bin/wc -l` -3}")
MY_UPDATES=`/usr/share/rpimonitor/scripts/check_zypper.pl`

if [ $MY_DEBUG == 1 ]; then
   /usr/bin/echo "DEBUG ON - Analyze data"
   /usr/bin/echo "Total packages installed is $MY_PACKAGES"
   /usr/bin/echo "Total patterns installed is $MY_PATTERNS"
   /usr/bin/echo "Total patches installed is $MY_PATCHES"
   # Check if less than zero and set to zero because no patterns or patches have been installed
   if [[ $MY_PATTERNS -lt 2 ]]; then
      echo "No patterns installed?"
      MY_PATTERNS=0
   fi
   if [[ $MY_PATCHES -lt 2 ]]; then
      echo "No patches installed?"
      MY_PATCHES=0
   fi
   /usr/bin/echo "Grand total of installed and System packages $MY_INSTALLED"
   # System packages are manual installs etc
   MY_SYSTEM=$(($MY_INSTALLED-($MY_PACKAGES+$MY_PATTERNS+$MY_PATCHES)))
   /usr/bin/echo "Total @System packages installed is $MY_SYSTEM"
   /usr/bin/echo "$MY_UPDATES"
else
   /usr/bin/echo "Packages:$MY_PACKAGES" > /var/lib/rpimonitor/updatestatus.txt
   # Check if less than zero and set to zero because no patterns or patches have been installed
   if [[ $MY_PATTERNS -lt 2 ]]; then
      MY_PATTERNS=0
   fi
   if [[ $MY_PATCHES -lt 2 ]]; then
      MY_PATCHES=0
   fi
   /usr/bin/echo "Patterns:$MY_PATTERNS" >> /var/lib/rpimonitor/updatestatus.txt
   /usr/bin/echo "Patches:$MY_PATCHES" >> /var/lib/rpimonitor/updatestatus.txt
   /usr/bin/echo "Installed:$MY_INSTALLED" >> /var/lib/rpimonitor/updatestatus.txt
   MY_SYSTEM=$(($MY_INSTALLED-($MY_PACKAGES+$MY_PATTERNS+$MY_PATCHES)))
   /usr/bin/echo "System:$MY_SYSTEM" >> /var/lib/rpimonitor/updatestatus.txt
   /usr/bin/echo "$MY_UPDATES" >> /var/lib/rpimonitor/updatestatus.txt
fi
