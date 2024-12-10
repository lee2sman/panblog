# panblog

panblog is a simple, minimal bash and pandoc-based static site generator. It takes markdown files and converts them to a website you can host on your own server, github pages, neocities and the like. 

panblog makes use of Pandoc, the swiss army knife of text file conversion. It makes use of pandoc's remarkable conversion tools, frontmatter variables, and custom templating: practically everything needed to make a static site.

## Rationale

panblog was created as an alternative to [Jekyll](https://jekyllrb.com/), [Hugo](https://gohugo.io/), and [11ty](https://www.11ty.dev/) and other static site generators. These three are great but I got frustrated with Jekyll breaking with dependency hell every couple months, or having to re-install the 'correct' version of ruby, bundler, and gems. I also didn't love that themes would break as Jekyll got progressively updated. Hugo was often mentioned to me as an alternative, and not changing nearly as often, but it's a large piece of complicated software. And the number of additional options to add-on can feel overwhelming. In contrast, 11ty was easy to jump into but I don't love npm and the node.js ecosystem because of how often there are changes, occasional security issues, and how packages get so bloated. I also looked into [bashblog](https://cfenollosa.github.io/bashblog/) but at 1500 lines of code, it was hard to hack on, and had features like Google analytics and Twitter integrations that I just didn't want. In contrast to all of these, 95% of the time I just need a landing page, blog pages, a header, and a folder of images, maybe a contact or about page, and optional rss feed. For this reason over the years I often found myself reaching for pandoc when creating small devlogs, class websites and the like. Over time I started creating small build scripts to automate using pandoc, which eventually grew into the foundation of panblog.

## Requirements

* Pandoc
* Bash
* tac (You probably have it already, such as from GNU coreutils or busybox) 
* basename (You probably have it already. If not, install coreutils)

## Quickstart

The fastest way to get started is to download or clone this repo and then 1. change or modify the files in the `posts` directory, 2. change the variable names in the `config.conf` file, then 3. run the build.sh script `bash build.sh`.

To see your site live in the browser, run a local server in the output `_site` directory (such as `python3 -m http.server`) and visit the url http://localhost:8000 in a web browser.

## Installing

Git clone or download this directory to your computer.

Give permissions to the build script:

```sh
chmod +x build.sh
```

It can now be run with `./build.sh`

### Setup

All custom variables are set in `config.conf`. Start by opening that file in any text editor and changing your site name, url and description. Multi-word strings should be placed in quotes.

All posts should be placed in the specified posts directory with the file name formatted in YYYY-MM-DD-title-name.md.

All non-post pages can be placed in the pages directory. By default, these pages will be built but won't be linked from any other page. Pages must be manually linked from other pages such as your site's home page, in templates/site_template.html or maybe a navigation bar in templates/header.html.

Place css stylesheet(s) in the themes directory. Place templates in the templates directory. Place your images in the images asset directory.

## Usage

All posts and pages can **optionally** include frontmatter, which pandoc and the build script will use when rendering the page. Frontmatter variables are placed between two sets of `---` at the top of a page of markdown, in the format:

```frontmatter
---
title: Title of your post
css: stylesheet-name.css
image: optional opengraph image file
description: optional opengraph page description
---
```

Opengraph (image, text, etc) are the preview you see populated when posting a link to a page on social media, for example.

A post or page without frontmatter still builds and uses a default title from its filename, and the config.conf default css theme. You can modify page templates, including the header and footer, nav or any other html elements in the templates folder.

All images should be placed in your images assets folder. You can just write the image filename in your posts and pages. When pandoc renders the markdown pages to html it will prepend the path to your image.

### Build entire site

```
./build.sh
```

This looks for all markdown files in the pages and posts directories, then builds a folder _site/ (or change site name directory in config.conf) with each post by default in its own sub-folder so you can have a clean URLs. All pages are built and placed in their own directory within pages.

### The difference between pages and posts

Posts are sourced from the posts directory and are automatically linked from your website's landing page, like a traditional blog. They must be saved under a file name with YYYY-MM-DD-title.md format. Pages are any markdown page in the pages directory. They are built and placed in the root folder but not automatically linked from the site homepage. You can manually link to them from any other page, or type their full URL path directly into the browser, such as `https://example.com/contact/`.

Example from a site landing page footer:

```markdown
To get in touch, [contact](contact/) me.
```

## Testing your site

Run a local server inside your _site folder through many different methods. Most computers have Python installed, so a local server is easy to setup.

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

FTP or otherwise upload the contents of your site's built directory (by default: _site) to the root of your web hosting folder, or to the www/ folder depending on how your server is set up.

Optionally, you can host the site via [GitHub pages](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site), GitLab, Sourcehut, and some other forges. If you're a member of a tilde server community, then you have access to tildegit and can host on [TildePages](https://tilde.wiki/Tildepages).

## Directory structure

Running build.sh will render the following default output site. 

```
_site/
- index.md        #compiled in build step
- index.html      #rendered output
- rss.xml
-----/css/
-------theme.css
-----/images/
-------image1.jpg
-------image2.jpg
-----/post1/      #linked from site index 
-------index.html 
-----/post2/      #linked from site index
-------index.html
-----/page1/      #not linked by default
-------index.html
```

## Themes

panblog comes with several theme options, which are just css files. A theme for your landing page should be specified in your templates files. Individual posts can use override with a different theme by specifying a css theme file in their front matter with the css keyword.

## License

cc0 Public Domain
