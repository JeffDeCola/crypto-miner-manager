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

echo "List whats in the current directory"
ls -la
echo " "

echo "DOCKER RUN ----------------------------------------------------------------------------"
echo " "

echo "$DOCKER_HOST_SSH_PRIVATE_KEY_FILE" > private-key-file.txt
cat private-key-file.txt
chmod 600 private-key-file.txt
echo " "

echo "docker run"
ssh -i private-key-file.txt -p "$DOCKER_HOST_PORT" "$DOCKER_HOST_USER"@"$DOCKER_HOST_IP" \
    'docker run --name crypto-miner-manager -dit jeffdecola/crypto-miner-manager'
echo " "

echo "rm private-key-file.txt"
rm private-key-file.txt
echo " "

echo "You can run docker command such as:"
echo "docker run --name crypto-miner-manager -dit jeffdecola/crypto-miner-manager"
echo "docker exec -i -t crypto-miner-manager /bin/bash"
echo "docker logs crypto-miner-manager"
echo "docker rm -f crypto-miner-manager"
echo " "

echo "deploy.sh (END)"
echo " "
