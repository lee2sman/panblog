---
title: An intro to panblog
description: I created panblog because I was frustrated with my regular jekyll static site generator and had increasingly turned to pandoc over the years to convert markdown to html.
---

Each year for the past decade I've needed to create roughly half a dozen new websites a year, from simple websites for a class, to a devlog for an ongoing project, to documentation sites.

I created panblog because I was frustrated with my regular jekyll static site generator and had increasingly turned to pandoc over the years to convert markdown to html. I gradually picked up more command line [incantations](https://pandoc.org/MANUAL) and knowledge of building my own templates and frontmatter metadata. 

Pandoc was created by [John MacFarlane](https://philosophy.berkeley.edu/people/detail/1), Professor of Philosophy at Berkeley.

> If you tried to figure out what philosophical logic was by looking in the literature, you might easily become confused. *--John MacFarlane, from the Preface to Philosophical Logic, A Contemporary Introduction*

That's a fun quote and a nice way to test out blockquotes in my css theme, but not related to textual conversion engines. That's okay. I like a well-rounded programmer-philosopher.

### How panblog works

When learning pandoc, the basic way to convert a markdown document to html is:

```sh
pandoc -s index.md -o index.html
```

Pandoc provides many more options. For example, the current command I'm using to build the site index is below and is at the heart of what panblog is: a glorified wrapper around pandoc. Note, you'll never have to type this yourself. It's part of the build script.

```sh
  pandoc --standalone --template templates/site_template.html -s $site_folder/index.md --metadata title="$site_name" -B templates/header.html -A templates/footer.html --metadata theme="css/$site_theme" -o $site_folder/index.html
```

This means roughly:

* Pandoc will create a complete (standalone) html file
* using the site_template.html file that has variables for placeholders
* converting the previously-generated index markdown file
* adding in the site name from the config
* adding in the header template
* adding in the footer template
* using the specified css theme from the config file
* outputting to the output folder specified in the config file

Of course, you'll never have to type that in directly, so you can forget all of that if you want, but it's also here to refer to if you ever want to go back and modify panblog yourself.

panblog is public domain software. You are free to modify and use the code however you wish.

## How to use panblog

panblog has documentation on its [project repo on tildegit](https://tildegit.org/exquisitecorp/panblog) and at this point assumes some basic understanding of working on the command line.

### To install:

```sh
git clone https://tildegit.org/exquisitecorp/panblog.git
cd panblog
chmod +x build.sh
```

You also need to have installed pandoc. And if you're on OS X, you may need to install coreutils to have tac and basename working.

### The basic quickstart is this:

* Modify the posts in the posts folder, or remove and replace them. The frontmatter section at the top of each post is optional.
* Modify the config.conf file in the root directory, and change the website title, url and anything else you desire
* Modify or add new pages in the the pages folder
* Modify the templates, especially templates/header.html and templates/footer.html
* Potentially you may want to switch out the CSS theme, or modify mine. I use classless CSS, so out of the box you don't need to add any special markdown beyond the normal headers, paragraphs, links and the like in your text files.

### To build your site:

```sh
./build.sh
```

You can find the rendered output site in the default _site folder. 

### To view it locally:

Go to your _site folder and run a local server there. See the project repo for more info on [testing your site](https://tildegit.org/exquisitecorp/panblog#testing-your-site).

### Uploading your site

You can [host your new website](https://tildegit.org/exquisitecorp/panblog#getting-your-site-online) on your own domain or at a free domain. You can use neocities.org, GitHub pages, Tildepages, or your own server. The details of how to upload or (s)ftp vary by program and server. This [demo site](https://exquisitecorp.tildepages.org/panblog-demo/) is hosted via [Tildepages](https://tildepages.org/).

For more info and to try it out, visit the [panblog project repo](https://tildegit.org/exquisitecorp/panblog).
