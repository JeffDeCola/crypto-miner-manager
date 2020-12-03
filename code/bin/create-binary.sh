#!/bin/sh -e
# crypto-miner-manager create-binary.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* create-binary.sh -debug (START) **************************************"
    echo "************************************************************************"
    # set -x enables a mode of the shell where all executed commands are printed to the terminal.
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* create-binary.sh (START) *********************************************"
    echo "************************************************************************"
    echo " "
fi

echo "Create a binary crypto-miner-manager in /bin"
echo "    Kick off executable with ./hello.go"
go build -o crypto-miner-manager ../crypto-miner-manager.go
echo " "

echo "************************************************************************"
echo "* create-binary.sh (END) ***********************************************"
echo "************************************************************************"
echo " "
