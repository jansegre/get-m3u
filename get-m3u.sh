#!/bin/bash

M3U="video.m3u"

DIRNAME="vid"
I=0

while [ -e "$DIRNAME$I" ]
do
I=`expr $I + 1`
done

OUTPUT_DIR="$DIRNAME$I"
mkdir "$OUTPUT_DIR"
OUTPUT_M3U="$OUTPUT_DIR/$M3U"

while read line
do

echo $line >> $OUTPUT_M3U

if echo "$line" | fgrep "EXTINF" > /dev/null
then

read url
FILENAME=`echo $url | grep "/\([^/?]*\)\??.*$" -o | sed -E "s/\/(.*)\?.*/\\1/"`
#echo "Downloding $url"
echo $FILENAME >> $OUTPUT_M3U

wget "$url" -O "$OUTPUT_DIR/$FILENAME"
#echo wget "$url" -O "$OUTPUT_DIR/$FILENAME"
fi

done
