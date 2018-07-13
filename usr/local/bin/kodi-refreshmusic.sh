#!/bin/sh

curl -i -X POST -d "{\"jsonrpc\": \"2.0\", \"method\": \"AudioLibrary.Clean\", \"id\": \"RPI-web\"}" -H "content-type:application/json" http://kodi:1234@localhost:9080/jsonrpc
exec kodi-rescanmusic.sh
