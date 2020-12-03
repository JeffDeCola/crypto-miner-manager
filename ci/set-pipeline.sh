#!/bin/bash
# catch-microservice set-pipeline.sh

fly -t ci set-pipeline -p catch-microservice -c pipeline.yml --load-vars-from ../../../../../.credentials.yml
