#Tool to quickly tagging all repositories for releases
#Adjust workspace accordingly to own setup

#!/bin/bash

read -p "What version of WSF?: `echo $'\n> '`" VERSION

WORKSPACE=$HOME/repo
CREPO=null

#Tagging Function
tag_current_repo () {
	git checkout master
	git pull
	git tag -m "Release of $VERSION" $VERSION
	git push origin $VERSION
	cd $WORKSPACE
}  > /dev/null 2>&1

#Clients
cd clients
echo "Tagging Client"
tag_current_repo



#Server
cd wsf/wsf-server
echo "Tagging WSF-Server"
tag_current_repo 

#Dashboard
cd wsf/dashboard
echo "Tagging Dashboard"
tag_current_repo

#services
cd wsf/services
echo "Tagging Services"
tag_current_repo

#configui
cd wsf/configui
echo "Tagging ConfigUI"
tag_current_repo

#Storage
cd wsf/storage
echo "Tagging Storage"
tag_current_repo

#Categorizer
cd wsf/categorizer
echo "Tagging Categorizer"
tag_current_repo

#Old Controller
cd wsf/wsf-controller
echo "Tagging (old) controller"
tag_current_repo



#Build tools
cd cicd/codesealer_build_tools
echo "Tagging Build Tools"
tag_current_repo

#Browsertest
cd cicd/browsertest
echo "Tagging Browsertests"
tag_current_repo

#WSFBT
cd cicd/wsf-browser-tests
echo "Tagging WSFBT"
tag_current_repo

#WOWTOOLS
cd cicd/wowtools
echo "WOWTOOLS"
tag_current_repo



#GO Bootloader
cd bootloader/go-bootloader
echo "Tagging GO-bootloader"
tag_current_repo


#Obfuscator
cd obfuscator
echo "Tagging Obfuscator"
tag_current_repo

echo "All repositories is now tagged with $VERSION"
done