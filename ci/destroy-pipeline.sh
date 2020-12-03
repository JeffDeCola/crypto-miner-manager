#!/bin/bash
# catch-microservice destroy-pipeline.sh

fly -t ci destroy-pipeline --pipeline catch-microservice
