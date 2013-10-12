#!/bin/sh
#
# author: Samuel Gaehwiler
#         sg@klangfreund.com
#
# created: 081215
# edit: 081224
#
# usage:
#  ./upload.sh <filename>

audiopath=/home/sam/www/podcast/audio/

filename=$1

wput -q $audiopath${filename}.mp3 ftp://fm4:pflapflutteri@ftp.klangfreund.com/audio/${filename}.mp3
wput -qnc /home/sam/www/podcast/samsfm4.xml ftp://fm4:pflapflutteri@ftp.klangfreund.com/samsfm4.xml
# "-nc" (= "−−dont−continue") is very important here, because otherwise wput would try to resume the smaller samsfm4.xml that's already on the server. This would lead to a nonvalid samsfm4.xml-file.