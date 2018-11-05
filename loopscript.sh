#!/bin/bash

repofolder='/Users/drexmawr/repo/'
currentdir=$PWD

echo 'TEST'
echo $currentdir
echo $PWD
echo ''


cd $repofolder
echo $PWD 
echo 'Brew update:'
brew update
echo 'Pulling updates from repositories:'
echo ''
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && echo "Updating:" && pwd && git pull" \;

cd $currentdir
