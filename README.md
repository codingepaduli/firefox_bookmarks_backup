# Firefox Bookmarks Backup in Markdown (repository archived)

This repository has been archived. 

The work has been splitted in two repository:

- The mozLz4-decompress library [https://github.com/codingepaduli/mozLz4-decompress])https://github.com/codingepaduli/mozLz4-decompress#mozlz4-decompress) to decompress the ``jsonlz4`` format (FireFox bookmarks) to ``JSON`` format;
- The python script [https://github.com/codingepaduli/firefox-bookmarks-to-markdown](https://github.com/codingepaduli/firefox-bookmarks-to-markdown#firefox-bookmarks-to-markdown) to convert the FireFox bookmarks from ``JSON`` to ``CommonMark``.

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
