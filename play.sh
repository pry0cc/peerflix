#!/bin/bash

while read line; do
	title=$(echo $line | jq -r .song_title)
	artist=$(echo $line | jq -r .artist)
	album=$(echo $line | jq -r .album)
	magnet=$(pirate-get -0 -C "echo %s" "$album - $artist" | tail -n 1)

	echo "Playing song $title"
	echo "Artist: $artist"
	echo "Album: $album"
	echo $magnet

	node ./app.js "$magnet" --mplayer --list -F "$title"
done < songlist.txt
