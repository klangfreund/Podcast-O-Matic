#!/bin/sh
#
# author: Samuel Gaehwiler
#         www.klangfreund.com
#
# created: 070102
# edit: 070103, 070119, 070127, 070325, 111231
#
# usage:
#  ./record.sh <your_file-description> <hours> <minutes> <seconds>
#
# output:
#  yymmdd_(start-hhmm)-(end-hhmm)_<your-file-description>.mp3

description=$1
hours=$2
minutes=$3
seconds=$4

audiopath=/home/sam/www/podcast/audio/

actualSecondsPlusInput=`echo \($(date +\%H)+${hours}\)*3600+\($(date +\%M)+${minutes}\)*60+\($(date +\%S)+${seconds}\) | bc`
secondsTotal=`echo ${hours}*3600+${minutes}*60+${seconds} | bc`

#begin filenamestuff --------------------------------------------------------------------
stop_minute=`echo ${actualSecondsPlusInput}/60%60 | bc`
  # to always get a 2 digit format:
  if [ `echo length\(${stop_minute}\) | bc` -eq 1 ]
  then
      stop_minute=0$stop_minute
  fi
stop_hour=`echo ${actualSecondsPlusInput}/3600%24 | bc`
  # to always get a 2 digit format:
  if [ `echo length\(${stop_hour}\) | bc` -eq 1 ]
  then
      stop_hour=0$stop_hour
  fi

filename=$(date +\%y\%m\%d_\%H\%M)-$stop_hour${stop_minute}_${description}
#end filenamestuff ----------------------------------------------------------------------

# record the fm4 mp3 stream:
ffmpeg -i http://mp3stream1.apasf.apa.at:8000 -acodec copy -t $secondsTotal $audiopath$filename.mp3

# add the mp3 to the podcast
/home/sam/scripts/add_to_podcast.sh $filename $secondsTotal &
