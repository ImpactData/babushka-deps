#!/bin/sh
#initiate heroku backup
export PATH=/usr/local/rvm/gems/ree-1.8.7-2011.03/bin:/usr/local/rvm/gems/ree-1.8.7-2011.03@global/bin:/usr/local/rvm/rubies/ree-1.8.7-2011.03/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export GEM_HOME=/usr/local/rvm/gems/ree-1.8.7-2011.03
#/usr/local/rvm/scripts/rvm
#echo $PATH
#rvm use ree
heroku pgbackups:capture --expire --app squawkbox
#get postgres backup files
HEROKU_PG_URL=`heroku pgbackups:url --app squawkbox`
echo $HEROKU_PG_URL
curl -o /backup/postgresql/freshest.dump $HEROKU_PG_URL
