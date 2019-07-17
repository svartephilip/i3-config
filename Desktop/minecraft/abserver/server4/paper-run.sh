#!/bin/sh

VERSION=${1}
~/scripts/push-to-git.sh
rm paperclip.jar
wget https://papermc.io/ci/job/Paper-$VERSION/lastSuccessfulBuild/artifact/paperclip.jar
sudo nice -n -10 java -jar paper*.jar
