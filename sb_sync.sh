#!/bin/sh
#get mongo files for both production and staging
sudo mongodump -h swan.mongohq.com:27114 -d app438149 -u heroku -p dzmszgwbcvsl8rhxtqp9rl -o /files/mongo
sudo mongodump -h pearl.mongohq.com:27091 -d app457548 -u heroku -p 1tcvkdn5otepg06t6u5zdp -o /files/mongo
#restore mongo database
mongorestore --db torsion-production /files/mongo/app438149
#invoke heroku backup process
rvm use ree
heroku pgbackups:capture --expire
#get postgres backup files
curl -o /files/postgresql/freshest.dump `heroku pgbackups:url --app squawkbox`
#restore postres database
pg_restore --verbose --clean --no-acl --no-owner --no-password -h 127.0.0.1 -U torsion -d torsion /files/postgresql/freshest.dump
#checkout production version of squawkbox  
rm -rf Squawkbox
mkdir Squawkbox
git clone git@github.com:ImpactData/Squawkbox.git ~/Squawkbox
echo "rvm use ree" > ~/Squawkbox/.rvmrc
cd ~/Squawkbox && git checkout production
cd ~/Squawkbox && rvm use ree && bundle install
chmod 777 -R ~/Squawkbox/log
#restart all services
sudo service nginx stop
sudo service nginx start
sudo service postgresql stop
sudo service postgresql start
sudo service mongodb stop
sudo service mongodb start
