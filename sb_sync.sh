#!/bin/sh
#checkout production version of squawkbox  
sudo service nginx stop
rm -rf /var/www/squawkbox
mkdir /var/www/squawkbox
git clone git@github.com:ImpactData/Squawkbox.git /var/www/squawkbox
echo "rvm use ree" > /var/www/squawkbox/.rvmrc
cd /var/www/squawkbox/ && git checkout production
cd /var/www/squawkbox/ && rvm use ree && bundle install
chmod 777 -R /var/www/squawkbox/log
sudo service nginx start
