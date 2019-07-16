#!/bin/sh

date=$(date +'%H:%M')
sudo sudo cp -r ~/Desktop/minecraft/abserver/server3/ ~/Desktop/minecraft/backup/server3-${date}/
sudo nice -n -10 java -Xms1G -Xmx1G -XX:+UseConcMarkSweepGC -jar spigot.jar
date=$(date +'%H:%M')
sudo sudo cp -r ~/Desktop/minecraft/abserver/server3/ ~/Desktop/minecraft/backup/server3-${date}/
