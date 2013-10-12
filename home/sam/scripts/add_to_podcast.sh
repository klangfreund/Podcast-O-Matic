#!/bin/sh
#
# author: Samuel Gaehwiler
#         www.klangfreund.com
#
# created: 070204
# edit: 070208, 070325, 081224, 120622
#
# usage:
#  ./add_to_podcast.sh <filename> <duration_in_seconds>

audiopath=/home/sam/www/podcast/audio/
audiourl=http://www.klangfreund.com/~fm4/audio/
remotexmlfile="fm4@88.80.223.208:~/public_html/samsfm4.xml"
rssfeedpath=/home/sam/www/podcast/
rssfeed=/home/sam/www/podcast/samsfm4.xml
rssfeedtemp=/home/sam/www/podcast/samsfm4temp.xml

filename=$1
filesize=`ls -l $audiopath${filename}.mp3 | awk '{print $5}'`

durationInSeconds=$2
seconds=`echo $durationInSeconds%60 | bc`
  # to always get a 2 digit format:
  if [ `echo length\($seconds\) | bc` -eq 1 ]
  then
      seconds=0$seconds
  fi
minutes=`echo $durationInSeconds/60%60 | bc`
  # to always get a 2 digit format:
  if [ `echo length\($minutes\) | bc` -eq 1 ]
  then
      minutes=0$minutes
  fi
hours=`echo $durationInSeconds/3600 | bc`
  # to always get a 2 digit format:
  if [ `echo length\($hours\) | bc` -eq 1 ]
  then
      hours=0$hours
  fi

# download samsfm4.xml from the server (maybe it's manually changed and so preferred over the local version) and replace the local samsfm4.xml
rsync -e ssh -az $remotexmlfile $rssfeed


# delete the last two lines of the rssfeed: "</channel>" and "</rss>"
sed 'N;$!P;$!D;$d' $rssfeed > $rssfeedtemp

# add the new recording to the rssfeed:
echo "<item>" >> $rssfeedtemp
echo "<title>$filename</title>" >> $rssfeedtemp
echo "<itunes:author>Samuel Gaehwiler</itunes:author>" >> $rssfeedtemp
#echo "<itunes:subtitle>$filename</itunes:subtitle>" >> $rssfeedtemp
echo "<itunes:summary>$filename</itunes:summary>" >> $rssfeedtemp
echo "<enclosure url=\"$audiourl${filename}.mp3\" length=\"$filesize\" type=\"audio/mpeg\" />" >> $rssfeedtemp
echo "<guid>$audiourl${filename}.mp3</guid>" >> $rssfeedtemp
echo "<pubDate>$(date -u)</pubDate>" >> $rssfeedtemp
echo "<itunes:duration>$hours:$minutes:$seconds</itunes:duration>" >> $rssfeedtemp
# echo "<itunes:keywords>fm4 unlimited</itunes:keywords>" >> $rssfeedtemp
echo "</item>" >> $rssfeedtemp

echo "" >> $rssfeedtemp

echo "</channel>" >> $rssfeedtemp
echo "</rss>" >> $rssfeedtemp

mv $rssfeedtemp $rssfeed

/home/sam/scripts/upload.sh $filename
