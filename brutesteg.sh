#!/bin/bash
# Bruteforce password protected file with using steghide and a specified wordlist

function usage {
    echo -e "\n"
    echo -e "*** BruteSteg..."
    echo -e "*** Make sure that steghide is installed --> apt install steghide \n"	
    echo -e "*** Usage:   ./butesteg.sh <file_to_bruteforce> <wordlist> "
    echo -e "*** Example: ./brutesteg.sh image1.jpg /root/rockyou.txt \n"
}

hash steghide 2>/dev/null || { echo >&2 "steghide is required but it's not installed.  Aborting."; exit 1; }

if [ $# -lt 2 ]; then
		if [ $0 == "--help" ] || [ $0 == "-h" ]; then
			usage	
			exit
		else
	    		usage
			exit 1 # error
		fi
else
	if [ $# == 2 ]; then
		if [ -f $1 ] && [ -f $2 ]; then
			echo -e "File:$1 Wordlist:$2\n"
			echo -e "Starting this shit !\n"
			for s in $(cat $2); do echo -e "Trying $s"; r=$(steghide extract -sf $1 -p $s -v 2>&1 >/dev/null);if [[ $r = *extracted* ]];then echo -e "\nW00t ! Password found : $s" && exit 1;fi; done
			echo -e "\nPassword not found :(\n"
		else
			echo -e "\nError ! Verify file or wordlist path ! \n"
		fi
	else
		echo -e "\n Error ! Too many parameters ! \n"
	fi
fi
