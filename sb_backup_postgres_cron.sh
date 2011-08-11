#!/bin/sh
#initiate heroku backup
rvm use ree
heroku pgbackups:capture --expire
#get postgres backup files
curl -o /files/postgresql/freshest.dump `heroku pgbackups:url --app squawkbox`
