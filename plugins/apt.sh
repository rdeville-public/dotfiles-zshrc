#!/usr/bin/env bash

# Set of alias for apt-get and derivative apt-get command
if command -v apt-get >/dev/null 2>&1; then
	if [[ "$(whoami)" == "root" ]]; then
		# Install the provided package name
		alias aptinst='apt-get install -V'
		# Perform an update of the available packages
		alias aptupd='apt-get update'
		alias aptupg='apt-get upgrade && apt-get autoremove'
		# Clean useless package and remove temporary downloaded packages
		alias aptcl='apt-get autoremove && apt-get autoclean'
		# Remove specified package
		alias aptrm='apt-get remove'
		# Do a update of package list, upgrade package and clean temporary files
		alias fullupdate='aptupd && aptupg && aptcl'
	else
		# Install the provided package name
		alias aptinst='sudo apt-get install -V'
		# Perform an update of the available packages
		alias aptupd='sudo apt-get update'
		alias aptupg='sudo apt-get upgrade'
		alias aptdupg='sudo apt-get dist-upgrade'
		# Clean useless package and remove temporary downloaded packages
		alias aptcl='sudo apt-get autoremove && sudo apt-get autoclean'
		# Remove specified package
		alias aptrm='sudo apt-get remove'
		# Do a update of package list, upgrade package and clean temporary files
		alias fullupdate='aptupd && aptupg && aptdupg && aptcl'
	fi
	# Perform a text based research for package
	alias apts='apt-cache search'
	# List installed files for a packaged
	alias pkglsf='dpkg --listfiles'
fi
