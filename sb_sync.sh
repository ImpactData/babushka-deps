#!/bin/sh
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
