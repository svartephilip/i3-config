#!/bin/sh

date=$(date +'%d/%m/%Y')

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github
cd /home/oskar/
git commit -m "Automatic commit at: ${date}"
git push -u origin master
