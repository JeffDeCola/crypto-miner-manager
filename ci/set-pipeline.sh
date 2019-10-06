#!/bin/bash
# crypto-miner-manager set-pipeline.sh

fly -t ci set-pipeline -p crypto-miner-manager -c pipeline.yml --load-vars-from ../../../../../.credentials.yml
