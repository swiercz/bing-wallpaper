Bing Wallpaper for bash
=====================

This script downloads "Bing wallpaper of the day" and keeps history of previous pictures.
Based on [thejandroman](https://github.com/thejandroman/bing-Wallpaper) script.

This bash script requires curl, grep and gawk tool installed in your system.

How to use?
-----------

Clone this repository and
`mv path/to/cloned/repository ~/.bing-wallpaper`
and then
`cd ~/.bing-wallpaper && sh setup.sh`

* in **bing-wallpaper.sh** set PICTURE_DIR variable to wherever you want to keep the current wallpaper. It defaults to ~/.bing-wallpaper/pictures
* in **bing-wallpaper.sh** set PICTURE_DIR_OLD to the path where you want to keep history of previous wallpapers. It defaults to ~/.bing-wallpaper/pictures_old
* in **bing-cron** set path of the script. It defaults to ~/.bing-wallpaper/bing-wallpaper.sh
* in **bing-cron** set the path of the log file. It defaults to ~/.bing-wallpaper/log.log
* you can change schedule settings in **bing-cron** to your personal needs. By default the script will be run at 9:20, 11:20, 13:20, 15:20, 17:20 and 19:20
* run `crontab bing-cron` to setup the cronjob.
* for Mac users: `system preferences` -> `desktop and screensaver`, add your wallpaper directory and set the auto changement i.e. to 15 mins

Problems?
--------

In case of problems with gawk command please check if you have gawk installed and the GAWK variable in **bing-wallpaper.sh** is set to the path from `which gawk`

In non-Mac systems you must set the wallpaper directory in system settings at your own. Feel free to send me some instructions for other OSes to be put here.

