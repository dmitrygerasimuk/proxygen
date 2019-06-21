#!/bin/bash
fontfile='vcr.ttf'

if [[ $# -eq 0 ]] ; then
	echo 'Dmitry is Awesome v. 0.1 2017-03-29'
    echo '-------------------'
    echo 'feed me with movies'
    echo '-------------------'
    echo 'drag files to the icon or just drop it here'
    echo 'output: 1280x720 2mbps h264 with watermark and TCG'
    echo 'font used:'$fontfile
    echo 'NOTE: This is EVALUATION version, if you see this software in the production please call me +79055419189'
    exit 1
fi

i=0
echo "PROGRESS:10"
for var in "$@"
do
	percent=$((200*$i/$# % 2 + 100*$i/$#))
	echo "PROGRESS:"$percent
	rnd=$RANDOM
(./ffmpeg  -nostdin  -loglevel info -hide_banner -progress "$var".progress.txt -y -i "$var" \
				 -vf "scale=1280:720, drawtext=fontfile=$fontfile: text='WATERMARK': fontcolor=white@0.1: \
				 fontsize=240: x=0: y=250,drawtext=fontfile=$fontfile: timecode='01\:00\:00\:00': r=25: fontcolor=0xFFFFFF: fontsize=48: x=480: y=650,
				 drawtext=fontfile=$fontfile: text='': fontcolor=0xFFFFFF@0.5: fontsize=512: x=600: y=360" \
				 -c:v libx264 -x264-params "nal-hrd=cbr" -b:v 2M \
				 "$var""_h264".mp4 ) 
rm "$var".progress.txt
let "i++" 
done
echo 
echo "----"
echo "DONE"
echo "----"
echo
