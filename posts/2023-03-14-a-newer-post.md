---
title: panblog is built on pandoc
description: I created panblog because I was frustrated with my regular jekyll static site generator and had increasingly turned to pandoc over the years to convert markdown to html.
---

Each year for the past decade I've needed to create roughly half a dozen new websites a year, from simple websites for a class, to a devlog for an ongoing project, to documentation sites.

I created panblog because I was frustrated with my regular jekyll static site generator and had increasingly turned to pandoc over the years to convert markdown to html. I gradually picked up more command line [incantations](https://pandoc.org/MANUAL) and knowledge of building my own templates and frontmatter metadata. 

Pandoc was created by [John MacFarlane](https://philosophy.berkeley.edu/people/detail/1), Professor of Philosophy at Berkeley.

> If you tried to figure out what philosophical logic was by looking in the literature, you might easily become confused. *--John MacFarlane, from the Preface to Philosophical Logic, A Contemporary Introduction*

When learning pandoc, the basic way to convert a markdown document to html is:

```sh
pandoc -s index.md -o index.html
```

Pandoc provides many more options, and the current Pandoc incantation for building the site's index is as follows:

```sh
  pandoc --standalone --template templates/site_template.html -s $site_folder/index.md --metadata title="$site_name" --metadata theme="css/$site_theme" -o $site_folder/index.html
```

