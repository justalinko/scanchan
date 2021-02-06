#!/bin/bash

source detect-error-sqli.db

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
	echo -e "["$lh" VULN "$n"] : ${1} "
	save_output "${1}"
else
	echo -e "["$lm" NOOT "$n"] : ${1} "
	
fi
}

__src_scan_sqli(){

	Filebrowser "SELECT WEB LIST" "`pwd`/output"

	if [[ $selection == "" ]]; then
		echo "Exiting program ..."
		exit 0
	else
		list=$(cat $filepath/$filename | tr "\n" "\n")
		for sql in $list
		do
			((cthread=cthread%10)); ((cthread++==0)) && wait
			CekSQLi ${sql} &
		done
	fi
}