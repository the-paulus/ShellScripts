#!/bin/bash

# Adds the necessary SELinux file contexts needed for static or custom sites, or sites utilizing frames or content management systems.

if [ $(whoami) != "root" ] || [ ! $(selinuxenabled 2> /dev/null ) ] 
then
	echo "You must be root and SELinux must be installed."
	exit
fi

# General website file contexts.
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/private"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/backup"
semanage fcontext -a -t httpd_log_t "/var/www/vhosts(/.*)?/logs"

semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/private"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/backup"
semanage fcontext -a -t httpd_log_t "/var/www/vhosts(/.*)?/subdomains(/.*)logs"


# Drupal site file contexts
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/sites(/.*)?/files"

semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/sites(/.*)?/files"

# Joomla! site file contexts
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/plugins/installer"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/libraries?"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/language"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/administrator/manifests/libraries"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/components"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/media"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/administrator/language"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/plugins"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/httpdocs/administrator/manifests/packages"

semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/plugins/installer"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/libraries"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/language"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/administrator/manifests/libraries"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/components"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/media"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/administrator/language"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/plugins"
semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/vhosts(/.*)?/subdomains(/.*)/httpdocs/administrator/manifests/packages"
