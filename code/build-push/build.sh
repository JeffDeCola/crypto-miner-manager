#!/bin/sh -e
# catch-microservice build.sh

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
echo "docker build -f build-push/Dockerfile -t jeffdecola/catch-microservice ."
docker build -f build-push/Dockerfile -t jeffdecola/catch-microservice .
echo " "

echo "Check Docker Image size"
echo "docker images jeffdecola/catch-microservice:latest"
docker images jeffdecola/catch-microservice:latest
echo " "

echo "Useful commands:"
echo "     docker run --name catch-microservice -dit jeffdecola/catch-microservice"
echo "     docker exec -i -t catch-microservice /bin/bash"
echo "     docker logs catch-microservice"
echo " "

echo "************************************************************************"
echo "* build.sh (END) *******************************************************"
echo "************************************************************************"
echo " "
