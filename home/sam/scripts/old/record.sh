#!/bin/sh
#
# author: Samuel Gaehwiler
#         sam@klangfreund.com
#
# created: 070102
# edit: 070103, 070119, 070127, 070325
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

# record the line-in signal:
#OLD: osascript /Users/sam/dev/record_with_audiorecorder.scpt $filename $secondsTotal
arecord -f cd -d $secondsTotal $audiopath$filename.wav
# -f: format
# -d: duration

# convert the wav to mp3 using lame
/home/sam/scripts/wav_to_mp3.sh $filename $secondsTotal &

# wav_to_mp3.sh calls add_to_podcast.sh which adds the mp3 to the podcast