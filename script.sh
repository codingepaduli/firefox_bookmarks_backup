#!/bin/bash

# Current directory
currentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get Mozilla profile folder from profile.ini
firefoxProfileFolder=`crudini --get "$HOME/.mozilla/firefox/profiles.ini" Profile0 Path`

# Mozilla Firefox bookmarks backup folder
firefoxBackup="$HOME/.mozilla/firefox/$firefoxProfileFolder/bookmarkbackups"

# Destination files for Markdown format of Mozilla Firefox bookmarks
othersBookmarksFilePath="$HOME/Sviluppo/SVN2/codingepaduli/content/interesting/Others.md"
developingBookmarksFilePath="$HOME/Sviluppo/SVN2/codingepaduli/content/interesting/Developing.md"
educationalBookmarksFilePath="$HOME/Sviluppo/SVN2/codingepaduli/content/interesting/Educational.md"


# Set the last backup
lastUpdatedFile=`ls -t "$firefoxBackup" | head -n1`

# decompress and pretty print the bookmarks.json
python3 "$currentDir/mozlz4.py" -d "$firefoxBackup/$lastUpdatedFile" "$currentDir/bookmarksRaw.json"
python3 -m json.tool "$currentDir/bookmarksRaw.json" > "$currentDir/bookmarks.json"

# print the Markdown header (sed is used to update the publishing date)
cat "$currentDir/Others.header.md" | sed "s/%/`date --date="yesterday" '+%Y-%m-%d'`/g" > "$othersBookmarksFilePath"
cat "$currentDir/Developing.header.md" | sed "s/%/`date --date="yesterday" '+%Y-%m-%d'`/g" > "$developingBookmarksFilePath"
cat "$currentDir/Educational.header.md" | sed "s/%/`date --date="yesterday" '+%Y-%m-%d'`/g" > "$educationalBookmarksFilePath"

# print the Markdown content
python3 "$currentDir/exportToMarkdown.py" "$currentDir/bookmarks.json" --denied 'Media e Download' 'Giustizia e leggi' 'Scuola' 'Concorsi' 'Altri segnalibri sparsi' 'Blog News e Link' '.Net' 'Scienze' 'Altri segnalibri' >> "$developingBookmarksFilePath"
python3 "$currentDir/exportToMarkdown.py" "$currentDir/bookmarks.json" --allowed '' 'Menu segnalibri' 'Scienze' 'Spacetime' 'Math' 'Medicine' 'Tech' 'History' 'Games' >> "$othersBookmarksFilePath"
python3 "$currentDir/exportToMarkdown.py" "$currentDir/bookmarks.json" --allowed '' 'Menu segnalibri' 'Scuola' 'Lezioni' 'Google suite' 'Inglese' 'Educazione civica' 'Fake news' 'Social network' 'GDPR e privacy' 'Informatica 1anno' 'Hardware' 'Windows' 'Office' 'Word' 'Powerpoint' 'Libreoffice' 'Professioni Informatiche' 'Informatica 3 anno' 'Sistemi e reti 3 anno' 'Sistemi e reti 4anno' 'TPSIT 4 anno' 'TPSIT 5 anno' 'Informatica 5 anno' 'Eventi' 'Domotica' >> "$educationalBookmarksFilePath"
