function chcuser()
{
  if [ -f /etc/domusers ]
  then
    USER=$(cat /etc/domusers | grep $1 | split -d':' -f 2)
    sudo sudo su -m -l $USER
}

function httpdocs()
{
	if [ $# -eq 2 ]
	then
		cd /var/www/vhosts/$1/subdomains/$2/httpdocs
	else
		cd /var/www/vhosts/$1/httpdocs
	fi
}
