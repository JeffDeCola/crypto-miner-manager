#!/bin/sh
# crypto-miner-manager deploy.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "deploy.sh -debug (START)"
    # set -e causes the shell to exit if any subcommand or pipeline returns a non-zero status. Needed for concourse.
    # set -x enables a mode of the shell where all executed commands are printed to the terminal.
    set -e -x
    echo " "
else
    echo "deploy.sh (START)"
    # set -e causes the shell to exit if any subcommand or pipeline returns a non-zero status.  Needed for concourse.
    set -e
    echo " "
fi

echo "GOAL ----------------------------------------------------------------------------------"
echo " "

echo "The goal is to deploy docker image to docker"
echo " "

echo "CHECK THINGS --------------------------------------------------------------------------"
echo " "

echo "At start, you should be in a /tmp/build/xxxxx directory with two folders:"
echo "   /crypto-miner-manager"
echo " "

echo "pwd is: $PWD"
echo " "

echo "DOCKER RUN ----------------------------------------------------------------------------"
echo " "

cd crypto-miner-manager
ls -lat

echo "docker run --name crypto-miner-manager -dit jeffdecola/crypto-miner-manager"
docker run --name crypto-miner-manager -dit jeffdecola/crypto-miner-manager
echo " "

echo "deploy.sh (END)"
echo " "
