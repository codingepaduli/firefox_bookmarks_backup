#!/bin/bash

# This script decompress the bookmarks.jsonl4 into bookmarks.json

# Current directory
currentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get the Mozilla profile folder from the file profiles.ini
firefoxProfileFolder=`crudini --get "$HOME/.mozilla/firefox/profiles.ini" Profile0 Path`

# Mozilla Firefox bookmarks backup folder
firefoxBackup="$HOME/.mozilla/firefox/$firefoxProfileFolder/bookmarkbackups"

# Set the last backup
lastUpdatedFile=`ls -t "$firefoxBackup" | head -n1`

# Set the output folder
outputFolder="$currentDir/output"

# Create the output folder if not exists
mkdir -p "$outputFolder"

# decompress and pretty print the bookmarks.json
python3 "$currentDir/mozlz4.py" -d "$firefoxBackup/$lastUpdatedFile" "$outputFolder/bookmarksRaw.json"
python3 -m json.tool "$outputFolder/bookmarksRaw.json" > "$outputFolder/bookmarks.json"

# CommonMark+YamlFrontmatter template for each category
othersBookmarksFilePath="$HOME/Sviluppo/SVN2/codingepaduli/content/interesting/Others.md"
developingBookmarksFilePath="$HOME/Sviluppo/SVN2/codingepaduli/content/interesting/Developing.md"
educationalBookmarksFilePath="$HOME/Sviluppo/SVN2/codingepaduli/content/interesting/Educational.md"

# print the Markdown header (sed is used to update the publishing date)
cat "$currentDir/Others.header.md" | sed "s/%/`date --date="yesterday" '+%Y-%m-%d'`/g" > "$othersBookmarksFilePath"
cat "$currentDir/Developing.header.md" | sed "s/%/`date --date="yesterday" '+%Y-%m-%d'`/g" > "$developingBookmarksFilePath"
cat "$currentDir/Educational.header.md" | sed "s/%/`date --date="yesterday" '+%Y-%m-%d'`/g" > "$educationalBookmarksFilePath"

# print the Markdown content
python3 "$currentDir/exportToMarkdown.py" "$outputFolder/bookmarks.json" --denied 'Media e Download' 'Giustizia e leggi' 'Scuola' 'Concorsi' 'Altri segnalibri sparsi' 'Blog News e Link' '.Net' 'Scienze' 'Altri segnalibri' >> "$developingBookmarksFilePath"
python3 "$currentDir/exportToMarkdown.py" "$outputFolder/bookmarks.json" --allowed '' 'menu' 'Scienze' 'Spacetime' 'Math' 'Medicine' 'Tech' 'History' 'Games' >> "$othersBookmarksFilePath"
python3 "$currentDir/exportToMarkdown.py" "$outputFolder/bookmarks.json" --allowed '' 'menu' 'Scuola' 'Lezioni' 'Google suite' 'Inglese' 'Educazione civica' 'Fake news' 'Social network' 'GDPR e privacy' 'Informatica 1anno' 'Hardware' 'Windows' 'Office' 'Word' 'Powerpoint' 'Libreoffice' 'Professioni Informatiche' 'Informatica 3 anno' 'Sistemi e reti 3 anno' 'Sistemi e reti 4anno' 'TPSIT 4 anno' 'TPSIT 5 anno' 'Informatica 5 anno' 'Eventi' 'Domotica' >> "$educationalBookmarksFilePath"
