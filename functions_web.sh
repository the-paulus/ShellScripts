function httpdocs()
{
	if [ $# -eq 2 ]
	then
		cd /var/www/vhosts/$1/subdomains/$2/httpdocs
	else
		cd /var/www/vhosts/$1/httpdocs
	fi
}
