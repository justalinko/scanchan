#!/bin/bash

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
			echo "$url"
			save_dork $url
		fi
	done
}

__src_dorking()
{
	read -p "BING DORK  >>" dork
	read -p "MAX SEARCH >>" page
for (( i = 0; i <= $page ; i++ )); do
	((cthread=cthread%10)); ((cthread++==0)) && wait
	BingDorker $i $dork ${page} &
done
}