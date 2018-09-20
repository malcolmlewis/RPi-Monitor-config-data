#   Simple makefile for RPi-Monitor-config-data

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

PREFIX?=/usr
BINDIR?=$(PREFIX)/bin
SBINDIR?=$(PREFIX)/sbin
DATADIR?=$(PREFIX)/share
LIB?=$(PREFIX)/lib
LOCALSTATEDIR?=/var
SYSCONFDIR?=/etc
SYSCONFIGDIR?=$(SYSCONFDIR)/sysconfig
UNITDIR?=$(LIB)/systemd/system

all:

install:
	# Install SUSE and openSUSE custom configuration files
	mkdir -p $(DESTDIR)$(SYSCONFDIR)/rpimonitor/template
	cp -a SUSE/*.conf $(DESTDIR)$(SYSCONFDIR)/rpimonitor/template/
	cp -a openSUSE/*.conf $(DESTDIR)$(SYSCONFDIR)/rpimonitor/template/
	# Install systemd timer, service and script to analyze installed packages, patches and patterns
	mkdir -p $(DESTDIR)$(DATADIR)/rpimonitor/web/scripts
	install -Dm0755 common/SUSE_rpimonitor_zypper.sh $(DESTDIR)$(DATADIR)/rpimonitor/web/scripts/rpimonitor_zypper.sh
	install -Dm0755 common/SUSE_rpimonitor_zypper.service $(DESTDIR)$(UNITDIR)/rpimonitor-zypper.service
	install -Dm0755 common/SUSE_rpimonitor_zypper.timer $(DESTDIR)$(UNITDIR)/rpimonitor-zypper.timer
	# Install firewall service definition
	install -Dm0644 common/SuSEfirewall2.RPi-Monitor $(DESTDIR)$(SYSCONFIGDIR)/firewalld/services/RPi-Monitor
	# Install zypper update script
	install -Dm0755 common/check_zypper.pl $(DESTDIR)$(DATADIR)/rpimonitor/scripts/check_zypper.pl
	# Install SUSE and openSUSE png's
	mkdir -p $(DESTDIR)$(DATADIR)/rpimonitor/web/img
	cp -a SUSE/*.png $(DESTDIR)$(DATADIR)/rpimonitor/web/img/
	cp -a openSUSE/*.png $(DESTDIR)$(DATADIR)/rpimonitor/web/img/
	# Install pihole helper, conf and icon
	install -Dm0755 common/SUSE_rpimonitor-pihole.sh $(DESTDIR)$(DATADIR)/rpimonitor/web/scripts/rpimonitor-pihole.sh
	install -Dm0644 common/openSUSE_pihole.conf $(DESTDIR)$(SYSCONFDIR)/rpimonitor/template/openSUSE_pihole.conf
	install -Dm0644 common/pihole.png $(DESTDIR)$(DATADIR)/rpimonitor/web/img/pihole.png
