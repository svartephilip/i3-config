#!/bin/sh

~/scripts/push-to-git.sh
sudo nice -n -10 java -jar paper*.jar
