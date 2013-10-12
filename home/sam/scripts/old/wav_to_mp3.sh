#!/bin/sh
#
# author: Samuel Gaehwiler
#         sg@klangfreund.com
#
# created: 070320
# edit: 070325, 080306
# 
#
# usage:
#  ./wav_to_mp3.sh <filename> <time in seconds>

audiopath=/home/sam/www/podcast/audio/
filename=$1
secondsTotal=$2


# Audiorecorder needs some time to write the wav-header, so lets sleep a little
sleep 5

lame -V 4 --vbr-new --silent $audiopath${filename}.wav $audiopath${filename}.mp3

rm $audiopath${filename}.wav
#mv $audiopath${filename}.wav $audiopath/trash/${filename}.wav

/home/sam/scripts/add_to_podcast.sh $filename $secondsTotal