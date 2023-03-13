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

echo "The goal is to send the app.json file to marathon"
echo "This is done in the marathon resource"
echo " "

echo "CHECK THINGS --------------------------------------------------------------------------"
echo " "

echo "List whats in the app.json file"
echo "cat crypto-miner-manager/crypto-miner-manager-code/deploy/app.json"
cat crypto-miner-manager/crypto-miner-manager-code/deploy/app.json
echo " "

echo "DEPLOY DONE IN PIPELINE ---------------------------------------------------------------"
echo " "

echo "The concourse pipeline will put app.json to mesos/marathon"
echo " "

echo "deploy.sh (END)"
echo " "
