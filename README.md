# Firefox Bookmarks Backup in Markdown

A simple script (bash / python) to backup all Firefox bookmarks in JSON and (in second step) to convert the JSON file in CommonMark+YamlFrontmatter in order to publish the bookmarks in GitHub pages (now is configured to be used by [Hugo static site generator](https://gohugo.io))

The script is customized for publishing two different category of bookmarks: "Developing" and "Others". So it use two Hugo templates, ``Developing.header.md`` and ``Others.header.md`` (in which are stored the front-matter as YAML headers). Add and/or edit the templates as your wish.

## Use

Edit the ``script.sh`` file and set the variables:

- ``firefoxBackup`` the Firefox backup folder (from which read the last backup);
- ``developingBookmarksFilePath`` The template to fill with bookmarks;
- ``othersBookmarksFilePath`` A second template to fill with other bookmarks;

Set denied bookmark folders and allowed bookmark folders in the script, like in the following code:
``--allowed '' 'Menu segnalibri' 'Scienze' 'Spacetime'``

Start the script:
``./script.sh``
