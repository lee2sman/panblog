# panblog

*Note: This project is currently in development as part of my #decemberadventure 2024 project. It may change a bit over the month and is not quite feature-complete currently.*

panblog is a simple, minimal bash and pandoc-based static site generator. It takes markdown files and converts them to a website you can host on your own server, github pages, neocities and the like. 

panblog makes use of Pandoc, the swiss army knife of text file conversion. It makes use of pandoc's remarkable conversion tools, frontmatter variables, and custom templating: practically everything needed to make a static site.

## Rationale

panblog was created as an alternative to [Jekyll](https://jekyllrb.com/), [Hugo](https://gohugo.io/), and [11ty](https://www.11ty.dev/) and other static site generators. These three are great but I got frustrated with Jekyll breaking with dependency hell every couple months, or having to re-install the 'correct' version of ruby, bundler, and gems. I also didn't love that themes would break as Jekyll got progressively updated. Hugo was often mentioned to me as an alternative, and not changing nearly as often, but I didn't love having to completely customize and spend so much time setting up Hugo. And the number of options to learn felt daunting. In contrast, 11ty seemed somewhat easy to jump into, especially since they publish starter template sites, but I don't love npm and the node.js ecosystem because of how often there are changes, occasional security issues, and how packages get so bloated. I also looked into [bashblog](https://cfenollosa.github.io/bashblog/) but at 1500 lines of code, it was hard to hack on, and had features like Google analytics and Twitter integrations that I just didn't want. In contrast to all of these, 95% of the time I just need a landing page, blog pages, a header, and a folder of images, maybe a contact or about page. For this reason over the years I often found myself reaching for pandoc when creating small devlogs, class websites and the like. Over time I started creating small build scripts to automate using pandoc, which eventually grew into the foundation of panblog.

## Requirements

* Pandoc
* Bash
* tac (such as from GNU coreutils or busybox)

## Quickstart

The fastest way to get started is to download or clone this repo and then 1. change or modify the files in the `posts` directory, 2. change the variable names in the `config.conf` file, then 3. run the build.sh script `bash build.sh`.

To see your site live in the browser, run a local server in the output `_site` directory (such as `python3 -m http.server`) and visit the url http://localhost:8000 in a web browser.

## Installing

Git clone or download this directory to your computer.

### Setup

All custom variables are set in `config.conf`. Start by opening that file in any text editor and changing your site name, url and description. Multi-word strings should be placed in quotes.

All pages can be placed in the pages directory.

All posts should be placed in the specified posts directory with the file name formatted in YYYY-MM-DD-title-name.md.

Place css stylesheets in the themes directory. Place templates in the templates directory. Place your images in the specified image assets directory.

## Usage

All posts and pages should include frontmatter in the format:

```
---
title: title in words
css: css-stylesheet-name.css
---
```

You can modify page templates, including the header and footer, nav or any other html elements in the templates folder.

### Build entire site

```
./build.sh
```

This looks for all markdown files in the pages and posts directories, then builds a folder _site/ (or change site name directory in config.conf) with each post by default in its own sub-folder so you can have a clean URLs. All pages are built and placed in their own directory within pages.

### The difference between pages and posts

*Note: this section is still in development and could change.* 

Posts are sourced from the posts directory and are automatically linked from your website's landing page, like a traditional blog. Pages are any markdown page in the root directory. They are built and placed in a directory in the root folder but not automatically linked from another page. You can specify their url to link to them. 

Example:

```markdown
Find my email address on my [contact](pages/contact) page.
```

## Testing your site

Run a local server inside your _site folder.

If you have python3 installed:

```
python3 -m http.server
```

If you have python2 installed:

```
python -m SimpleHTTPServer
```

You can then visit the site running locally from your web browser at http://localhost:8000

The default port is 8000. You can optionally specify a port by appending it to the end, e.g. `python3 -m http.server 8080`


## Getting your site online

FTP or otherwise upload the contents of your site's built directory (by default: _site) to the root of your web hosting folder.

Optionally, you can host the site via [GitHub pages](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).

## Directory structure


Running build.sh will render the following default output site. 

```
_site/
- index.md    #compiled in build step
- index.html  #rendered output
-----/post1/
-------index.html
-----/post2/
-------index.html
```

## Themes

panblog comes with several theme options. A theme should be specified in your templates files.

## License

cc0 Public Domain
