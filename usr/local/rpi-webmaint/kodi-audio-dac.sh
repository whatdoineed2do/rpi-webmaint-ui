#!/bin/sh

curl -v -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Settings.SetSettingValue", "params":{"setting":"audiooutput.audiodevice","value":"ALSA:@"},"id":1}' http://kodi:1234@localhost:9080/jsonrpc
curl -v -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Settings.GetSettingValue", "params":{"setting":"audiooutput.audiodevice"},"id":1}' http://kodi:1234@localhost:9080/jsonrpc

