#!/bin/sh

SMARTCTL=$(which smartctl 2> /dev/null)

if [ $? -ne 0 ]
then    
    echo "smartctl not found. Do you have permission to run it?"
    exit
fi

BLUE="\033[1;34m"
CYAN="\033[0;36m"
GREEN="\033[0;32m"
NOCOLOR="\033[0m"

function get_wear_leveling_count(){
  
    if [ $# -ne 1 ]
    then
        exit
    fi
    
    echo $($SMARTCTL -A $1 | grep 177 | awk '{print $10}')
    
}

function get_data_written(){
    
    if [ $# -ne 1 ]
    then
        exit
    fi

    lbas_written=$($SMARTCTL -A $1 | grep 241 | awk '{print $10}')
    
    echo $(( $lbas_written*512 ))
    
}

NOW=`date +%s`
ssd_drives=( "/dev/sde" "/dev/sdf" )
ssd_dates=("12/17/2015" "12/17/2015")
ssd_days=( $((($NOW - `date -d ${ssd_dates[0]} +%s`)/(60*60*24))) $((($NOW - `date -d ${ssd_dates[1]} +%s`)/(60*60*24))))
ssd_tbw=( 75 75 )

count=0

for i in ${ssd_drives[@]}
do
    echo -e "\n${BLUE}$i${NOCOLOR}"
	wear_level=$( get_wear_leveling_count $i )
	echo -e "${CYAN}Wear level: ${GREEN}${wear_level}${NOCOLOR}"
	
	data_written=$( get_data_written $i )
	lifetime_data=$((${ssd_tbw[$count]} * 1099511627776))
    life=$(echo "scale=2; (($data_written / $lifetime_data)) * 100" | bc)
	
	echo -e "${CYAN}Health    : ${GREEN}$life% ${NOCOLOR}"
	
	echo -e "${CYAN}Endurance : "
	echo -e "\t   ${GREEN} $((${data_written} / 1048576)) / $((${ssd_tbw[$count]} * 1049000000)) MB${NOCOLOR}"
	echo -e "\t   ${GREEN} $((${data_written} / 1073741824)) / $((${ssd_tbw[$count]}*1048576)) GB${NOCOLOR}"
	echo -e "\t   ${GREEN} $((${data_written} / 1099511627776)) / ${ssd_tbw[$count]} TB${NOCOLOR}"
	
	echo -e "${CYAN}Data / day:${NOCOLOR}"
	echo -e "\t   ${GREEN} $(((${data_written} / 1048576)/${ssd_days[$count]}))${NOCOLOR} MB"
	echo -e "\t   ${GREEN} $(((${data_written} / 1073741824)/${ssd_days[$count]}))${NOCOLOR} GB"
	echo -e "\t   ${GREEN} $(((${data_written} / 1099511627776)/${ssd_days[$count]}))${NOCOLOR} TB"
	count=$(($count+1))
done
