#!/bin/bash
#wget https://www.ynetnews.com/category/3082
grep -Eo 'https://www.ynetnews.com/article/(([a-z])|([A-Z])|([0-9])){9}*' 3082 > links.txt

uniq links.txt > links_no_reps.txt
echo >results.csv
cat links_no_reps.txt | wc -l >results.csv
while IFS=  read -r url; do
	wget -q -O url "$url"
	bbs=$(grep -c "Netanyahu" url)
	bns=$(grep -c "Bennett" url)
	if [[ "$bbs" -eq "0" ]] && [[ "$bns" -eq "0" ]]; 
	then
		echo "$url, -"\ >>results.csv
	else
		echo "$url, Bennet, $bns, Netanyahu, $bbs"\ >>results.csv
	fi
	
done <links_no_reps.txt
