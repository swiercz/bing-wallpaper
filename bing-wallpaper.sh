#!/usr/bin/env bash
# Simple bing picture of the day downloader
# Author: Przemysław Świercz <przemyslaw.swiercz@gmail.com>
# 02 Feb 2014

# directories to keep wallpaper of the day and archive
PICTURE_DIR="$HOME/.bing-wallpaper/pictures/"
PICTURE_DIR_OLD="$HOME/.bing-wallpaper/pictures_old/"

# attempt to create directories
mkdir -p $PICTURE_DIR
mkdir -p $PICTURE_DIR_OLD

# Commands
PING="/sbin/ping"
GAWK="/usr/local/bin/gawk"

echo $(date)

# test Internet connection
connection_ok=0
for i in {1..3}
do
  test=$( $PING -q -c 1 8.8.4.4 | grep received | cut -d ' ' -f 4)
  if [[ test -eq 1 ]]; then
    connection_ok=1
    break
  else
    sleep 8
  fi
done
if [[ connection_ok -ne 1 ]]; then
  echo -e "Internet is no more\n"
  exit 1
fi

# urls and primary/secondary resolution
bing="http://www.bing.com"
xml="http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-US"
res="_1920x1200.jpg"
res2="_1366x768.jpg"

# extract image url and filename
url=$(curl -s "$xml" | $GAWK 'match($0, /<urlBase>(.*)<\/urlBase>/, u) {print u[1]}' )
filename=$(echo $url | $GAWK 'match($0, /\/([^\/]*)_EN/, n){print n[1]}' )

# check if file already exists
if [ -e $PICTURE_DIR/$filename.jpg ]; then
  echo "File $filename.jpg already exists in the download directory."
  exit 0
else
  # archive current wallpaper
  mv $PICTURE_DIR/* $PICTURE_DIR_OLD
fi

# download primary resulotion image
echo $bing$url$res
curl -Lo "$PICTURE_DIR/$filename.jpg" $bing$url$res

# if failed, try to download secondary resolution
head=$(head -c 9 "$PICTURE_DIR/$filename.jpg")
if [[ $head == "<!DOCTYPE" ]]; then
  echo $bing$url$res2
  curl -Lo "$PICTURE_DIR/$filename.jpg" $bing$url$res2
fi

