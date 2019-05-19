#!/bin/sh

date=$(date +'%d/%m/%Y')

cd ~/
git commit -m "Automati commit at: ${date}"
git push -u origin master
