#!/bin/sh
#initiate heroku backup
/usr/local/rvm/scripts/rvm
export PATH=$PATH:/usr/local/rvm/bin:/usr/local/rvm/gems/ree-1.8.7-2011.03/bin
echo $PATH
rvm use ree
heroku pgbackups:capture --expire --app squawkbox
#get postgres backup files
HEROKU_PG_URL=`heroku pgbackups:url --app squawkbox`
echo $HEROKU_PG_URL
curl -o /backup/postgresql/freshest.dump $HEROKU_PG_URL
