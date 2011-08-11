#!/bin/sh
#initiate heroku backup
rvm use ree
heroku pgbackups:capture --expire --app squawkbox
#get postgres backup files
curl -o /backup/postgresql/freshest.dump `heroku pgbackups:url --app squawkbox`
