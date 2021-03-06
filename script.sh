#!/bin/bash

# Current directory
currentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Mozilla Firefox bookmarks backup folder
firefoxBackup="$HOME/.mozilla/firefox/user.default/bookmarkbackups"

# Destination files for Markdown format of Mozilla Firefox bookmarks
othersBookmarksFilePath="$HOME/Sviluppo/SVN/codingepaduli/content/interesting/Others.md"
developingBookmarksFilePath="$HOME/Sviluppo/SVN/codingepaduli/content/interesting/Developing.md"


# Set the last backup
lastUpdatedFile=`ls -t "$firefoxBackup" | head -n1`

# decompress and pretty print the bookmarks.json
python3 "$currentDir/mozlz4.py" -d "$firefoxBackup/$lastUpdatedFile" "$currentDir/bookmarksRaw.json"
python3 -m json.tool "$currentDir/bookmarksRaw.json" > "$currentDir/bookmarks.json"

# print the Markdown header (sed is used to update the publishing date)
cat "$currentDir/Others.header.md" | sed "s/%/`date --date="yesterday" '+%Y-%m-%d'`/g" > "$othersBookmarksFilePath"
cat "$currentDir/Developing.header.md" | sed "s/%/`date --date="yesterday" '+%Y-%m-%d'`/g" > "$developingBookmarksFilePath"

# print the Markdown content
python3 "$currentDir/exportToMarkdown.py" "$currentDir/bookmarks.json" --denied 'Media e Download' 'Giustizia e leggi' 'Concorsi' 'Altri segnalibri sparsi' '.NET' 'Scienze' 'Altri segnalibri' >> "$developingBookmarksFilePath"
python3 "$currentDir/exportToMarkdown.py" "$currentDir/bookmarks.json" --allowed '' 'Menu segnalibri' 'Scienze' 'Spacetime' 'Math' 'Medicine' 'Tech' 'History' 'Games' >> "$othersBookmarksFilePath"
