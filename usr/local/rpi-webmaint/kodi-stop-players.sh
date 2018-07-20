#!/bin/sh

curl -v -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Player.Stop", "params":{"playerid":1},"id":1}' http://kodi:1234@localhost:9080/jsonrpc
curl -v -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Player.Stop", "params":{"playerid":2},"id":1}' http://kodi:1234@localhost:9080/jsonrpc
