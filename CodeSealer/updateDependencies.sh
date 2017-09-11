#!/bin/bash


#Clean up from previous updates
rm -f -r ${HOME}/dependenciesTemp


#Setup
export GOB=`which go`
alllist=${HOME}/repo/cicd/codesealer_build_tools/go/dependenciesList.txt
mkdir ${HOME}/dependenciesTemp
cd ${HOME}/dependenciesTemp
param=$1

#Loop configuration
IFS=$'\n'
set -f

if [ $1 == "all" ]; then
	for i in $(cat < "$alllist"); do 
		cd ${HOME}/dependenciesTemp
		GU=$i

		echo "Downloading '${GU}'"
		${GOB} get -u "${GU}"

		echo "Building '${GU}'"
		${GOB} build "${GU}"
		echo "Building for windows '${GU}'"
		GOOS=windows ${GOB} build "${GU}"
		echo ""
	done


#elif [[ $1 == *"github.com"* ]]; then
elif grep -q -E $1 $alllist; then
	cd ${HOME}/dependenciesTemp
	echo "Downloading $1"
	${GOB} get -u "$1"
	echo "Building $1"
	${GOB} build "$1"
	echo "Building for windows '$1'"
	GOOS=windows ${GOB} build "$1"


else
	echo "Argument failure, try again"
fi


#Cleanup
rm -f -r ${HOME}/dependenciesTemp




#Uploads specified file to artifactory in a give path
#curl --user admin:codesealer -X PUT "http://artifactory:8081/artifactory/third-party/testtxt" -T ~/testtxt