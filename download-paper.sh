#!/bin/bash

set -e
echo 1000 > /proc/$$/oom_score_adj

MC_VERSION=1.21
PAPER_VERSION=${*:-latest}

if [[ "${PAPER_VERSION}" -eq "latest" ]]; then
  PAPER_VERSION=$(curl -fsS "https://papermc.io/api/v2/projects/paper/versions/${MC_VERSION}" | jq .builds[-1])
fi
echo ${PAPER_VERSION}

FILENAME=paper-${MC_VERSION}-${PAPER_VERSION}.jar
# TEMPFILE=$(mktemp).jar

curl -fL "https://papermc.io/api/v2/projects/paper/versions/${MC_VERSION}/builds/${PAPER_VERSION}/downloads/${FILENAME}" > ${FILENAME}

# PAPER_VERSION=$(java -jar ${TEMPFILE} --version | tail -n 1)
# PAPER_VERSION=${PAPER_VERSION#git-Paper-}
# FILENAME=paper-${MC_VERSION}-${PAPER_VERSION}.jar

echo "Downloaded ${FILENAME}"
# mv ${TEMPFILE} ${FILENAME}
ln -sf ${FILENAME} paper-${MC_VERSION}.jar
