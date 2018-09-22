## Customization of RPi-Monitor configuration for SUSE SLES, openSUSE Leap and openSUSE Tumbleweed.

### Daemon manual configuration for shellinabox (/etc/rpimonitor/daemon.conf)

1. You need to configure shellinabox and add hostname/ip address at daemon.shellinabox=https://

2. Since it's a self signed certificate you will need to add an exception in your web browser of
   choice, for example in Firefox: Preferences -> Advanced -> View Certificates and Add Exception
   button and enter the Url (https://(fqdn or ip address):4200/).

3. If running a firewall the port needs to be open (default: 4200) for remote access.

### Daily systemd timer for packages, patterns, patches installed and if updates are available.

1. The script /usr/share/rpimonitor/scripts/rpimonitor-zypper.sh and associated systemd timer
   and service has been added to run a daily check of installed files via zypper.

2. The script /usr/share/rpimonitor/scripts/check_zypper.pl from the nagios zypper plugin package
   has been added to check if updates available. See https://en.opensuse.org/Nagios-plugins-zypper

3. To see the status of the systemd timer service, run the command;

   `systemctl status rpimontor-zypper.timer`

### Pihole integration.

1. The script /usr/share/rpimonitor/rpimonitor-pihole.sh (and softlink in /usr/bin) uses the
   telnet-api to access pihole-FTL socket for relevant information to populate the RPi-Monitor
   status page. It can also be run from the command line eg;

   `rpimonitor-pihole.sh`
   `Usage: /usr/bin/rpimonitor-pihole.sh <stats,top-domains,top-ads,top-clients,recentBlocked>`

   (Ref: https://docs.pi-hole.net/ftldns/telnet-api/)

2. To add pihole status you need to edit the data.conf and remove the # from;
   * include=/etc/rpimonitor/template/openSUSE_pihole.conf

### Include files (/etc/rpimonitor/template)

1. Main configuration file is SUSE.conf or openSUSE.conf, this file needs to be a softlink to
   /etc/rpimonitor/data.conf.

    * SUSE and openSUSE

      `rm /etc/rpimonitor/data.conf`

   * For SUSE

     `ln -s /etc/rpimonitor/template/SUSE.conf /etc/rpimonitor/data.conf`

   * For openSUSE

     `ln -s /etc/rpimonitor/template/openSUSE.conf /etc/rpimonitor/data.conf`

   * Set web.page.icon to point at the logo to display in the top bar.
   * Set include (your customizations files) configuration files to use and fullpath.
   * Add web friends configuration to point to SUSE and openSUSE Home page and forums.

2. Customized file(s) avialable to date for SUSE.conf;
   * include=/etc/rpimonitor/template/SUSE.conf
   * include=/etc/rpimonitor/template/SUSEmemory.conf
   * include=/etc/rpimonitor/template/SUSE_network.conf
   * include=/etc/rpimonitor/template/SUSE_pihole.conf
   * include=/etc/rpimonitor/template/SUSE_sdcard_btrfs.conf
   * include=/etc/rpimonitor/template/SUSE_temperature.conf
   * include=/etc/rpimonitor/template/SUSE_sdcard_btrfs.conf
   * include=/etc/rpimonitor/template/SUSE_uptime.conf
   * include=/etc/rpimonitor/template/SUSE_version.conf

3. Customized file(s) avialable to date for openSUSE.conf;
   * include=/etc/rpimonitor/template/Leap.conf
   * include=/etc/rpimonitor/template/openSUSE.conf
   * include=/etc/rpimonitor/template/openSUSE_cpu.conf
   * include=/etc/rpimonitor/template/openSUSE_network.conf
   * include=/etc/rpimonitor/template/openSUSE_pihole.conf
   * include=/etc/rpimonitor/template/openSUSE_sdcard.conf
   * include=/etc/rpimonitor/template/openSUSE_temperature.conf
   * include=/etc/rpimonitor/template/openSUSE_uptime.conf
   * include=/etc/rpimonitor/template/openSUSE_usb_hdd.conf
   * include=/etc/rpimonitor/template/Tumbleweed_version.conf

### RPi-Monitor Interactive Configuration Helper (part of RPi-Monitor package)

1. If you want to add additional configuration file checks, then at the command line
   run the command;

   `rpimonitord -i`

   This is a tool to help you to define the parameter of the configuration file:
   source, regexp, postprocess and type.

### Logo and icon sources

1. openSUSE: https://github.com/openSUSE/artwork
   * https://raw.githubusercontent.com/openSUSE/artwork/master/Logo/official-logo-color.svg
   * Convert to Height 32 and png
   * Rename to openSUSE-logo-color.png

   `convert -background none -density 1000 -resize x32 official-logo-color.svg openSUSE-logo-color.png`

2. openSUSE Leap
   * https://raw.githubusercontent.com/openSUSE/artwork/master/Logo/Leap/Leap-green.svg
   * Convert to Height 64 and png

   `convert -background none -density 1000 -resize x64 Leap-green.svg Leap-green.png`

3. openSUSE Tumbleweed
   * https://raw.githubusercontent.com/openSUSE/artwork/master/Logo/Tumbleweed/Tumbleweed-green.svg
   * Convert to Height 64 and png

   `convert -background none -density 1000 -resize x64 Tumbleweed-green.svg Tumbleweed-green.png`

4. SUSE: https://www.suse.com/brandcentral/suse/
   * Extracted from https://www.suse.com/brandcentral/suse/download/suse-logo.zip
   * Path:- suse-logo/suse_logo_screen/suse_logo_color.png
   * Convert to Height 32 and rename to SUSE-logo-color.png

   `convert -resize x32 logo_orig/suse-logo/suse_logo_screen/suse_logo_color.png SUSE-logo-color.png`

   * Extracted from https://www.suse.com/brandcentral/suse/download/suse-logomark.zip
   * Path:- suse-logomark/suse_icon_screen/SUSE_icon_color.png
   * Convert to Height 64 and rename to SUSE-icon-color.png

   `convert -resize x64 logo_orig/suse-logomark/suse_icon_screen/SUSE_icon_color.png SUSE-icon-color.png`

5. Pihole: https://github.com/pi-hole/pi-hole
   * https://raw.githubusercontent.com/pi-hole/AdminLTE/master/img/favicon.png
   * Convert to Height 64 and png
   * Rename to pihole.png

   `convert -resize x64 favicon.png pihole.png`

### Contacting the Author

I can be contacted via email to malcolmlewis -at- opensuse -dot- org
