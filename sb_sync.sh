#!/bin/sh
#checkout production version of squawkbox  
#sudo service nginx stop
export PATH=/usr/local/rvm/gems/ree-1.8.7-2011.03/bin:/usr/local/rvm/gems/ree-1.8.7-2011.03@global/bin:/usr/local/rvm/rubies/ree-1.8.7-2011.03/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export GEM_HOME=/usr/local/rvm/gems/ree-1.8.7-2011.03 
rm -rf /var/www/squawkbox
mkdir /var/www/squawkbox
git clone git@github.com:ImpactData/Squawkbox.git /var/www/squawkbox
echo "rvm use ree" > /var/www/squawkbox/.rvmrc
cd /var/www/squawkbox/ 
git checkout production
#rvm use ree
#echo $PATH
#echo $GEM_HOME
bundle install
chmod 777 -R /var/www/squawkbox/log
mkdir /var/www/squawkbox/tmp
chmod 777 -R /var/www/squawkbox/tmp
#sudo service nginx start
