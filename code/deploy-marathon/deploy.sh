#!/bin/sh
# catch-microservice deploy.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "deploy.sh -debug (START)"
    echo " "
    # set -x enables a mode of the shell where all executed commands are printed to the terminal.
    set -x
    echo " "
else
    echo " "
    echo "deploy.sh (START)"
    echo " "
fi

echo "Send app.json file to marathon"
curl -X PUT http://192.168.20.117:8080/v2/apps/catch-long-running -d @app.json -H "Content-type: application/json"
echo " "

echo "deploy.sh (END)"
echo " "
