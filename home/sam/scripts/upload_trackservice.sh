#!/bin/sh
#
# author: Samuel Gaehwiler
#         www.klangfreund.com
#
# created: 090106
# edit: 120622
#
# usage:
#  ./upload_trackservice.sh

localeTrackservicepath=/home/sam/www/trackservice/
remoteTrackservicepath="fm4@88.80.223.208:~/public_html/trackservice/"

rsync -e ssh -az $localeTrackservicepath $remoteTrackservicepath

