#!/bin/bash

open_terminal()
{
	Filebrowser "SELECT VULN LIST" "`pwd`/output"

	if [[ $selection == "" ]]; then
		echo "Exiting program ..."
		exit 0
	else
		list=$(cat $filepath/$filename | tr "\n" "\n")
		for sql in $list
		do
			xfce4-terminal -e 'bash -c "sqlmap -u '${sql}'; bash"' -T "ScanChan: Working for $sql"
			sleep 2
		done
	fi
}
basic_scan()
{
	Filebrowser "SELECT VULN LIST" "`pwd`/output"

	if [[ $selection == "" ]]; then
		echo "Exiting program ..."
		exit 0
	else
		sqlmap -m $filepath/$filename --crawl=1 --
	fi
}

__src_auto_sqlmap(){


	echo "[1]. MASS OPEN TERMINAL ( xfce4-terminal )"
	echo "[2]. BASIC MASS SCANNER "
	read -p "choose >>" open
	if [[ $open == 1 ]]; then
		open_terminal
	else
		basic_scan
	fi
	
}