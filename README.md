# Firefox Bookmarks Backup in Markdown

A simple script (bash / python) to backup all Firefox bookmarks in CommonMark+YamlFrontmatter in order to be (manually) published by a static site generator (I use [Hugo static site generator](https://gohugo.io))

The script is customized for publishing different categories of bookmarks: "Developing", "Interesting", "Others", ect... . Each category has a sort of Hugo template, like ``Developing.header.md`` and ``Others.header.md``, in which are stored the front-matter as YAML headers. Add and/or edit the templates as your wish.

## Summary

- [Prerequisites](#prerequisites)
- [Use](#use)
- [Development](#development)
  - [TODO](#todo)
  - [Script customization](#script-customization)

## Prerequisites

Linux compatible OS. 

Ensure to install the following libraries:

```bash
lzma python3-lz4 crudini
```

Firefox profile is saved in ````$HOME/.mozilla/firefox/profiles.ini``.

Firefox bookmarks are saved in a folder like ``$HOME/.mozilla/firefox/$FF_PROFILE_ID.default[-esr]/bookmarkbackups/bookmarks-xyz...abc.jsonlz4``.

## Use

Edit the file ``script.sh`` and set the variables:

- ``firefoxProfileFolder`` the Firefox profiles folder (contains the file ``profiles.ini``);

Start the script:
``./script.sh``

## Development

### TODO 

I need to split this work in two repository, the first with the conversion from the ``jsonlz4`` format (FireFox bookmarks) to the ``JSON`` format, the second with the custom script from ``JSON`` to ``CommonMark+YamlFrontmatter``. I hope I will work on this soon...

### Script customization

FireFox bookmarks are structured as a tree. Each node is interpreted as a category. You need to choose each category to allow or to deny in output.

In order to allow all the bookmarks of a category, you need to pass as argument the category and all the parent categories, like the following:

```bash
python3 "$currentDir/exportToMarkdown.py" "$currentDir/bookmarks.json" --allowed '' 'menu' 'Scienze' 'Spacetime' 'Math' 'Medicine' 'Tech' 'History' 'Games'
```

In order to allow all the categories, except someone, you need to pass as argument the categories to skip, as the following:

```bash
python3 "$currentDir/exportToMarkdown.py" "$currentDir/bookmarks.json" --denied 'Media e Download' 'Giustizia e leggi' 'Scuola' 'Concorsi'
```

The bookmarks will be added to a Hugo template, like ``Developing.header.md`` and ``Others.header.md``. These templates contain the front-matter as YAML headers. The output of the previous commands are simply appended to the template file.
