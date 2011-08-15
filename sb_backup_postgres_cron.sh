#!/bin/sh
#initiate heroku backup
rvm use ree 
ruby -rubygems /usr/local/rvm/gems/ree-1.8.7-2011.03/bin/heroku pgbackups:capture --expire --app squawkbox
#get postgres backup files
HEROKU_PG_URL=`ruby -rubygems /usr/local/rvm/gems/ree-1.8.7-2011.03/bin/heroku pgbackups:url --app squawkbox`
echo $HEROKU_PG_URL
curl -o /backup/postgresql/freshest.dump $HEROKU_PG_URL
