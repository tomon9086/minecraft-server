#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
PWD=$(pwd)
TMP_PATH=${DIR}/tmp
SPIGOT_PATH=${DIR}/spigot
BUILD_TOOLS_PATH=${TMP_PATH}/BuildTools.jar

MC_VERSION=1.16.5

function build () {
  # download spigot build tools
  mkdir -p ${TMP_PATH}
  if [ ! -f ${BUILD_TOOLS_PATH} ]; then
    curl -o ${BUILD_TOOLS_PATH} https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
  fi

  # build spigot
  mkdir -p ${SPIGOT_PATH}
  if [ -z "$(ls -A ${SPIGOT_PATH})" ]; then
    cd ${SPIGOT_PATH} && \
      java -Xmx1024M -jar ${BUILD_TOOLS_PATH} --rev ${MC_VERSION}
    rm -rf ${SPIGOT_PATH}/**/.git/
  else
    echo "${SPIGOT_PATH} is not empty"
    cd ${PWD}
    return 1
  fi
  cd ${PWD}
}

function run_server () {
  cd ${SPIGOT_PATH}
  echo 'eula=true' >> eula.txt
  SERVER_JAR_PATH=$(find . -name 'spigot-*.jar' | head -n 1)
  java -jar ${SERVER_JAR_PATH}
  cd ${PWD}
}
