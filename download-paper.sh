#!/bin/sh

set -e
echo 1000 > /proc/$$/oom_score_adj

MC_VERSION=26.2
PAPER_BUILD=${*:-latest}

API="https://fill.papermc.io/v3/projects/paper/versions/${MC_VERSION}/builds/${PAPER_BUILD}"
BUILD_INFO=$(mktemp)
trap 'rm -f "${BUILD_INFO}"' EXIT
curl -fsS "${API}" -o "${BUILD_INFO}"

DOWNLOAD_URL=$(jq -r '.downloads."server:default".url' "${BUILD_INFO}")
FILENAME=$(jq -r '.downloads."server:default".name' "${BUILD_INFO}")

curl -fL "${DOWNLOAD_URL}" -o "${FILENAME}"
ln -sf "${FILENAME}" "paper-${MC_VERSION}.jar"

echo "Downloaded ${FILENAME}"
