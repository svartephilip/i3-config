#!/bin/sh

VERSION=${1}
~/scripts/push-to-git.sh
sudo rm ./paperclip.jar
sudo wget https://papermc.io/ci/job/Paper-$VERSION/lastSuccessfulBuild/artifact/paperclip.jar
sudo nice -n -10 java -jar paper*.jar
