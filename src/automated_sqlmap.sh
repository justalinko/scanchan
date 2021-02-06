#!/bin/bash


__src_auto_sqlmap(){

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