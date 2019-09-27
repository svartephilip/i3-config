#!/bin/sh

~/scripts/push-to-git.sh
sudo nice -n -10 java -Xms1G -Xmx1G -XX:+UseConcMarkSweepGC -jar forge*.jar nogui
