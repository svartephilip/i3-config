#!/bin/sh

sudo cp ./ ~/Desktop/minecraft/backup/
sudo nice java -Xms1G -Xmx1G -XX:+UseConcMarkSweepGC -jar spigot.jar
