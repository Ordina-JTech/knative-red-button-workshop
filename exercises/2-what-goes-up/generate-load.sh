#!/usr/bin/env bash

SERVICE_DOMAIN="http://hello-tijmen1.tijmen.52.214.236.14.sslip.io";
NUMBER_OF_CONCURRENT_CALLS=7;

counter=1
while [ $counter -le ${NUMBER_OF_CONCURRENT_CALLS} ]
    do
    curl -s ${SERVICE_DOMAIN}/calc &
    ((counter++))
done