# panblog

Note: panblog is still in development and may continue to change, have bugs, destroy your computer, make your hand fall off, etc.


panblog is a simple, minimal bash and pandoc-based static site generator. It takes a flat file directory of markdown files and can build a website inside a folder, or you can add just a new post to an existing panblog.

panblog makes use of Pandoc, and specifically the template feature which allows the creation of html templates that include custom header and footer.

## Installing

Git clone or download this directory to your computer.

## Usage

Two ways to use:

### Build entire site

```
./build.sh
```

Looks for all markdown files in the directory, then builds a folder site/ (or change name in template/build.sh) with each post by default in its own sub-folder so you can have a clean URLs.

e.g.

```
site/
- index.md
- index.html
-----/post1/
-------index.html
-----/post2/
-------index.html
```

### Create a single post and add to site

```
./post.sh postname.md
```

Takes a single specified file and adds it to the site/ folder (or change in template/post.sh) with each post by default in its own sub-folder.

## Themes

panblog comes with several theme options. A theme should be specified in your templates files.

## License

cc0 Public Domain

Issues / pull requests considered.
