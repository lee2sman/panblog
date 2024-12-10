---
title: Frontmatter, Images and Opengraph tags
image: museum.jpg
description: Here's the scoop on opengraph, why you may want to use it, and how panblog works with them.
---

## What is OpenGraph?

OpenGraph tags in HTML5 enable allowing your pages to populate data when embedded in social media (Mastodon, Bluesky, Slack, etc). When you post a link, if the page has a title, image, description in opengraph html tags, that info will populate where it's shared.

## How does this relate to Panblog?

Admittedly, not everyone needs this, but I was looking for a way to do it, since many of the sites I make are blogs or blog-like, and I or others might want to share links to individual posts, and it might be nice to have the advantage of having an image and description pop up where it's linked. To do that, opengraph tags need to be on the page.

To add opengraph tags (optional!) to one of your pages, you can add a title, image, description to your frontmatter. 

### Working with images in Panblog

All images get placed in the images directory. Or edit the config.conf file and select a different directory. Thereafter, you can simply add an image as normal in markdown, like this without having to prepend the image directory name:

```markdown
![ARoS museum](museum.jpg)  
```

Which turns into:

![ARoS museum](museum.jpg)  

That's the ARoS Museum in Aarhus, Denmark, where I took part in an artist-in-residency.
