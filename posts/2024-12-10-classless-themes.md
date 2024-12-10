---
title: panblog is built with classless CSS
---

I designed panblog's shipped default theme to be a [classless css](https://github.com/dbohdan/classless-css) file. In fact, all of the shipped themes are classless. Classless CSS is the easiest way to get started styling a website as it does not require you to individually mark up and add special IDs and classes by hand to your html files. The idea is that you drop in a classless CSS theme you select and your site "just works."

You can just write your posts and pages in text and save as markdown and then run the build script and the css theme will automatically work with them.

With some basic knowledge of HTML and CSS you could modify the theme if you like. In particular, good starting points are to change the background and foreground colors in the body, or even the color gradient I use as a background for the body. A potentially even easier approach to doing so would be to change the default theme in the config.conf file to fresh.css. Then open the fresh.css file and change out the colors listed at the top in the css color variables section. You can find a [list of named CSS colors](https://www.w3schools.com/cssref/css_colors.php) on the w3schools site if you don't want to write in hex values. I also like the [RandomA11y](https://randoma11y.com/) website to generate accessible 2-color palettes.

Go wild. Or not.

