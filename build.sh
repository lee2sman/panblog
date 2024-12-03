#!/bin/bash

function set_paths {
  # change if you have a different config file
  CONFIG_PATH=config.conf
}

function check_valid {
  # source config file
  if [ ! -e $CONFIG_PATH ]; then
    echo "$CONFIG_PATH not found"
    exit 1
  fi

  # Source the config file
  . $CONFIG_PATH

  if [[ -z $site_name || -z $site_url || -z $site_description || -z $site_feed || -z $site_dir || -z $site_posts || -z $site_assets ]]; then
    echo "$CONFIG_PATH missing arguments."
    exit 1
  fi
}

function source_config {

  # set site destination folder
  site_folder=$(grep -oP '(?<=site_dir=).*' $CONFIG_PATH)

  # make site folder if doesn't exist
  mkdir -p $site_folder
  #echo $site_folder

# set posts folder to value in config
  POSTS_PATH=$(grep -oP '(?<=site_posts=).*' $CONFIG_PATH)

  # make posts folder if it doesn't exist
  mkdir -p $POSTS_PATH
  #echo $POSTS_PATH

  #set feed_name to site_feed value in config
  feed_name=$(grep -oP '(?<=site_feed=).*' $CONFIG_PATH)
  
  touch $site_folder/$feed_name
}

function create_site {

  # START BUILD
  echo "Building $site_name..."

  # copy over themes
  #mkdir -p "$site_dir"/css
  mkdir -p "$site_folder/css"
  cp -r themes/*.css "$site_folder/css/"

  # copy over assets
  mkdir -p "$site_dir/$site_assets"
  cp -r assets/* "$site_dir/$site_assets/"

  #erases site index, start from scratch
  > $site_folder/index.md 

  # build site index
  touch $site_folder/index.md

  # Convert posts to html
  # add them to index in most recent date order

  # uncomment next line to list oldest posts from top to bottom
  #for file in $site_posts/*.md

  # uncomment next line to print newest posts from top to bottom
  # tac may not be installed on os x
  ls $site_posts/*.md | tac | while read file;
  do
    #convert spaces in name to hyphen, if you have rename
    #this needs to be tested/debugged
    #if command -v rename &> /dev/null;
    #then
     # rename "s/ /-/g" $file
    #fi

    #strip .md extension from filename to get page name
    #post_name=$(basename --suffix=.md $file)
    pattern='*[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-'
    post_name_suffix="${file/$pattern}"
    post_name=$(basename $post_name_suffix .md)
    post_date="${file:6:10}"

    # uncomment this section if you prefer flat hierarchy postname.md -> postname.html in single folder
    # pandoc --standalone --template templates/template.html $1 -o $site_folder/"${file.md}.html"

    # uncomment this section if you prefer posts to be in their own subfolder so permalinks are website.com/postname/
    mkdir -p $site_folder/$post_name
    pandoc --resource-path=$site_assets --extract-media=../$site_assets --standalone --template templates/post_template.html $file -o $site_folder/$post_name/index.html

    echo "[$post_name]($post_name/)  ">>$site_folder/index.md
    echo "$post_date  ">>$site_folder/index.md
    echo "">>$site_folder/index.md

  done

  # build index
  pandoc --standalone --template templates/site_template.html $site_folder/index.md --metadata title="$site_name" -o $site_folder/index.html
}

function create_feed {
  # feed meta
  > $site_folder/$feed_name #erases file, start from scratch
  echo '<rss version="2.0">'>> $site_folder/$feed_name
  echo "<channel>" >> $site_folder/$feed_name
  echo "<title>$site_name</title>" >> $site_folder/$feed_name
  echo "<link>$site_url</link>" >> $site_folder/$feed_name
  echo "<description>$site_description</description>" >> $site_folder/$feed_name

  # individual feed items
  for file in $POSTS_PATH/*.md
  do
    echo "<item>" >> $site_folder/$feed_name
    # get individual title
    echo "<title>" >> $site_folder/$feed_name
    grep -oP '(?<=title: ).*' $file >> $feed_name
    echo "</title>" >> $site_folder/$feed_name

    # get individual url
    echo "<link>" >> $site_folder/$feed_name
    echo $site_url/${file// /-} >> $site_folder/$feed_name
    echo "</link>" >> $site_folder/$feed_name

    # echo formatted pubdate
    echo "<pubDate>" >> $site_folder/$feed_name
    # thanks to https://lynxbee.com/create-pubdate-tag-in-rss-xml-using-linux-date-command/#.ZA9akY7MJhF
    pubDate=$(grep -oP '(?<=date: ).*' $file)
    date -d "$pubDate" +"%a, %d %b %Y %H:%M:%S %z" >> $site_folder/$feed_name
    echo "</pubDate>" >> $site_folder/$feed_name

    # echo description of each item
    echo "<description>" >> $site_folder/$feed_name
    ## wrap html content in a CDATA for rss 2.0 spec
    echo "<![CDATA[" >> $site_folder/$feed_name
    pandoc --to=html5 -o - $file | cat >> $site_folder/$feed_name
    echo "]]>" >> $site_folder/$feed_name
    echo "</description>" >> $site_folder/$feed_name

    echo "</item>" >> $site_folder/$feed_name
  done

  echo -e '</channel>
  </rss>' >> $site_folder/$feed_name
}

#-----------------------MAIN--------------------------
set_paths
check_valid
source_config
create_site
create_feed
