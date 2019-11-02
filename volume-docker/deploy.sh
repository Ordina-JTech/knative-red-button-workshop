#!/usr/bin/env bash
set -e

## To be changed by participant
export KNATIVE_NAMESPACE=""
export KNATIVE_SERVICE=""

# log file, not to be changed by participant
export LOG_FILE=/volume-docker/output-deploy-script.log

# Setup cloud configuration, not to be change by participant
kubectl config set-context --current --namespace=${KNATIVE_NAMESPACE}

echo "Starting deployment at: $(date +"%T")"                  > ${LOG_FILE} 2>&1

echo                                                          >> ${LOG_FILE} 2>&1
echo '===================='                                   >> ${LOG_FILE} 2>&1
echo 'Setting up environment...'                              >> ${LOG_FILE} 2>&1

echo                                                          >> ${LOG_FILE} 2>&1
echo '===================='                                   >> ${LOG_FILE} 2>&1
echo 'Verifying namespace...'                                 >> ${LOG_FILE} 2>&1
kubectl get namespace ${KNATIVE_NAMESPACE} --no-headers=true  >> ${LOG_FILE} 2>&1

echo                                                          >> ${LOG_FILE} 2>&1
echo '===================='                                   >> ${LOG_FILE} 2>&1
echo 'Running deployment...'                                  >> ${LOG_FILE} 2>&1

# To be changed by participant (keep it on one line and make sure '>> ${LOG_FILE} 2>&1' is at the end of the line)
kn service create --help                                      >> ${LOG_FILE} 2>&1




echo                                                          >> ${LOG_FILE} 2>&1
echo '===================='                                   >> ${LOG_FILE} 2>&1
echo "Finished deployment at: $(date +"%T")"                  >> ${LOG_FILE} 2>&1
echo                                                          >> ${LOG_FILE} 2>&1
echo '===================='                                   >> ${LOG_FILE} 2>&1
echo 'List of services currently deployed:'                   >> ${LOG_FILE} 2>&1
kn service list                                               >> ${LOG_FILE} 2>&1

echo                                                          >> ${LOG_FILE} 2>&1
echo '===================='                                   >> ${LOG_FILE} 2>&1
echo 'pods currently active:'                                 >> ${LOG_FILE} 2>&1
kubectl get pods -n ${KNATIVE_NAMESPACE}                      >> ${LOG_FILE} 2>&1
echo                                                          >> ${LOG_FILE} 2>&1
echo '===================='                                   >> ${LOG_FILE} 2>&1

exit 0