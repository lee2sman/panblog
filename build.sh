#!/bin/bash

# change if you'd like a different destination directory
site_folder=site

# templates folder location
templates=templates

# make site folder if doesn't exist
mkdir -p $site_folder

# copy over themes
mkdir -p "$site_folder"/css
cp -r themes/*.css "$site_folder"/css


for file in *.md
do
  post_name=$file

  # uncomment this section if you prefer flat hierarchy postname.md -> postname.html in single folder
  # pandoc --standalone --template templates/template.html $1 -o $site_folder/"${file.md}.html"

  # uncomment this section if you prefer posts to be in their own subfolder so permalinks are website.com/postname/
  mkdir -p $site_folder/$post_name
  pandoc --standalone --template $templates/post_template.html $file -o $site_folder/$post_name/index.html

  # build site index
  touch $site_folder/index.md
  echo "[$post_name]($post_name/)">>$site_folder/index.md
  echo ""

done

pandoc --standalone --template $templates/site_template.html $site_folder/index.md -o $site_folder/index.html
