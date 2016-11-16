#!/bin/bash

# Creates file context rules for Drupal website files, logs, and backups.

if [ $(whoami) != "root" ] && [ ! $(selinuxenabled 2> /dev/null ) ] 
then
	echo "You must be root and SELinux must be installed."
	exit
fi

semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/sites(/.*)?/files"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/private"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/backup"
semanage fcontext -a -t httpd_log_t "/var/www/vhosts(/.*)?/logs"

semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/sites(/.*)?/files"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/private"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/backup"
semanage fcontext -a -t httpd_log_t "/var/www/vhosts(/.*)?/subdomains(/.*)logs"
