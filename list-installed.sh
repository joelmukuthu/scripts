#!/bin/bash

# source: http://askubuntu.com/a/250530
function list-installed() {
	(zcat $(ls -tr /var/log/apt/history.log*.gz); cat /var/log/apt/history.log) | \
		egrep '^(Start-Date:|Commandline:)' | \
		grep -v aptdaemon | egrep '^Commandline:'
}
