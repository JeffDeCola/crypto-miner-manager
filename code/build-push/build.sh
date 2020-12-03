#!/bin/sh -e
# crypto-miner-manager build.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* build.sh -debug (START) **********************************************"
    echo "************************************************************************"
    # set -x enables a mode of the shell where all executed commands are printed to the terminal.
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* build.sh (START) *****************************************************"
    echo "************************************************************************"
    echo " "
fi

echo "cd to where go code is"
echo "cd .."
cd ..

echo "Build your docker image using Dockerfile"
echo "NOTE: The binary is built using this step"
echo "docker build -f build-push/Dockerfile -t jeffdecola/crypto-miner-manager ."
docker build -f build-push/Dockerfile -t jeffdecola/crypto-miner-manager .
echo " "

echo "Check Docker Image size"
echo "docker images jeffdecola/crypto-miner-manager:latest"
docker images jeffdecola/crypto-miner-manager:latest
echo " "

echo "Useful commands:"
echo "     docker run --name crypto-miner-manager -dit jeffdecola/crypto-miner-manager"
echo "     docker exec -i -t crypto-miner-manager /bin/bash"
echo "     docker logs crypto-miner-manager"
echo " "

echo "************************************************************************"
echo "* build.sh (END) *******************************************************"
echo "************************************************************************"
echo " "
