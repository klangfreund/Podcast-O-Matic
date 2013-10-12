#!/bin/sh
#
# author: Samuel Gaehwiler
#         www.klangfreund.com
#
# created: 081215
# edit: 081224
# edit: 120622
#
# usage:
#  ./upload.sh <filename>

audiopath=/home/sam/www/podcast/audio/
remoteAudioPath="fm4@88.80.223.208:~/public_html/audio/"
xmlFile=/home/sam/www/podcast/samsfm4.xml
remoteXmlFilePath="fm4@88.80.223.208:~/public_html/"

filename=$1

rsync -e ssh -az $audiopath$filename.mp3 $remoteAudioPath
rsync -e ssh -az $xmlFile $remoteXmlFilePath
# a: Archive, It is a quick way of saying you want recursion and want
#    to preserve almost everything.
# z: Compress the files so less bandwidth is needed, and the files are copied faster.
