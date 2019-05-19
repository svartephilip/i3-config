#!/bin/sh

date=$(date +'%d/%m/%Y')

cd /home/oskar/
git commit -m "Automatic commit at: ${date}"
git push -u origin master
