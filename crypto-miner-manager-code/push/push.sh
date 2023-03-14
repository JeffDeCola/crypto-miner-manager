#!/bin/sh -e
# crypto-miner-manager push.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* push.sh -debug (START) ***********************************************"
    echo "************************************************************************"
    # set -x enables a mode of the shell where all executed commands
    # are printed to the terminal.
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* push.sh (START) ******************************************************"
    echo "************************************************************************"
    echo " "
fi

echo "Assuming you are logged in, lets push your built docker image to DockerHub"
echo "To login to docker use:"
echo "    docker login"
echo "docker push jeffdecola/crypto-miner-manager"
docker push jeffdecola/crypto-miner-manager
echo " "

echo "************************************************************************"
echo "* push.sh (END) ********************************************************"
echo "************************************************************************"
echo " "