#!/bin/sh

LASTEST_PLAYLIST=$(ls -tr /var/lib/mpd/playlists/recent-*.m3u | tail -1)

REFRESH=0

if [ ! -z $LASTEST_PLAYLIST ]; then
    if [ /var/lib/mpd/tag_cache -nt $LASTEST_PLAYLIST ]; then
	REFRESH=1
    fi
fi

[ $REFRESH -eq 0 ] && exit 0

for i in 3 10 30 60; do
    find /media/music/ -type f -name "*.flac" -o -name "*.mp3" ! -mtime +${i} \
      | sed -e "s#^/media/##" > /var/lib/mpd/playlists/recent-${i}d.m3u
done

