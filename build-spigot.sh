#!/bin/bash
# Usage: ./build.sh --rev 1.12

set -e

mkdir -p workspace
pushd workspace
curl -fLO https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
java -jar BuildTools.jar $*
mv spigot-*.jar ../
popd
