#!/bin/bash

set -e

PAPER_VERSION=${*:-lastSuccessfulBuild}
FILENAME=paperclip-${PAPER_VERSION}.jar
TEMPFILE=$(mktemp).jar

[[ "${PAPER_VERSION}" -eq "lastSuccessfulBuild" ]] && FILENAME=paperclip.jar
curl -fL "https://papermc.io/ci/job/Paper-1.15/${PAPER_VERSION}/artifact/${FILENAME}" > ${TEMPFILE}

PAPER_VERSION=$(java -jar ${TEMPFILE} --version | tail -n 1)
PAPER_VERSION=${PAPER_VERSION#git-Paper-}
FILENAME=paperclip-${PAPER_VERSION}.jar

echo "Downloaded ${FILENAME}"
mv ${TEMPFILE} ${FILENAME}
ln -sf ${FILENAME} paperclip.jar
