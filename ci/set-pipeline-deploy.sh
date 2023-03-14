#!/bin/sh
# crypto-miner-manager set-pipeline.sh

echo " "
echo "Set pipeline on target jeffs-ci-target which is team jeffs-ci-team"
fly --target jeffs-ci-target \
    set-pipeline \
    --pipeline crypto-miner-manager-deploy \
    --config pipeline-deploy-only.yml \
    --load-vars-from ../../../.credentials.yml \
    --check-creds
echo " "
