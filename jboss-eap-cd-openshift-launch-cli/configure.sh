#!/bin/sh
set -e

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

#Final CLI script file
CLI_SCRIPT_FILE=$JBOSS_HOME/bin/launch/script.cli

# Add custom configuration file
cp -p ${ADDED_DIR}/standalone-openshift.xml $JBOSS_HOME/standalone/configuration/

# Common uitl methods for CLI
cp -p ${ADDED_DIR}/cli-common.sh ${JBOSS_HOME}/bin/cli-common.sh

#Add custom launch script and dependent scripts/libraries/snippets
cp -p ${ADDED_DIR}/openshift-launch.sh ${JBOSS_HOME}/bin/openshift-launch.sh

chown -R jboss:root ${JBOSS_HOME}/bin/
chmod -R g+rwX ${JBOSS_HOME}/bin/
