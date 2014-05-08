#!/usr/bin/env bash
gawk "{ gsub(\"/Users/memek\",\"$HOME\",\$0); print \$0 }" bing-cron > tmp.tmp
mv tmp.tmp bing-cron

