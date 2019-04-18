#!/bin/bash 

if [ $# -ne 1 ] ; then
  echo "no path to monitor"
  exit 1
fi
if [ ! -d $1 ]; then
  echo "not a directory"
  exit 1
fi
cd $1

inotifywait -q -e create,moved_to -m $1  --format "%e: %f" | while read f; do
  IEVNT=$(echo $f | cut -f1 -d ':')
  [ "$IEVNT" != "CREATE" -a "$IEVNT" != "MOVED_TO" ] && continue

  FILE=$(echo $f | sed -e "s/^CREATE: //g" -e "s/^MOVED_TO: //g")
  [ -L $FILE ] && continue

  FILE_MIME_TYPE=$(file -b -L --mime-type $FILE)
  if [ $? -eq 0 -a "$FILE_MIME_TYPE" == "video/mp4" ]; then
    [ -L previous.mp4 ] && rm previous.mp4
    [ -L latest.mp4 ]   && mv latest.mp4 previous.mp4
    ln -s $FILE latest.mp4
  fi
done

