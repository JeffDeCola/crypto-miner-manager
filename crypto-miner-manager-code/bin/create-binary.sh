#!/bin/sh -e
# crypto-miner-manger create-binary.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* create-binary.sh -debug (START) **************************************"
    echo "************************************************************************"
    # set -x enables a mode of the shell where all executed commands
    # are printed to the terminal.
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* create-binary.sh (START) *********************************************"
    echo "************************************************************************"
    echo " "
fi

echo "Create a binary crypto-miner in /bin"
echo "    Kick off executable with ./crypto-miner-manager"
go build -o crypto-miner-manager ../main.go
echo " "

echo "************************************************************************"
echo "* create-binary.sh (END) ***********************************************"
echo "************************************************************************"
echo " "
