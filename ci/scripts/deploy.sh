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
echo "This is done in the ????? resource"
echo " "

echo "DEPLOY DONE IN PIPELINE ---------------------------------------------------------------"
echo " "

echo "The concourse pipeline will ??????"
echo " "

echo "deploy.sh (END)"
echo " "
