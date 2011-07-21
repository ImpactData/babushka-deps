#!/bin/sh
#******************************************************************************
# command line
#******************************************************************************
# notes

# install native ruby required by babushka
sudo apt-get install ruby ri rdoc irb ri1.8 ruby1.8-dev libzlib-ruby zlib1g
# user should be a member of root group
sudo usermod -a -G root <username>
bash -c "`wget -O - babushka.me/up`"
babushka source -a impactdata git://github.com/MarkMagnus/squawk_babushka_dep.git

#git and curl
babushka 'core:curl.managed'
babushka 'core:git'

#then:
#git config --global user.name "Your GitHub ID"
#git config --global user.email "Your GitHub/Heroku email"
babushka 'impactdata:setup.git'

#ruby-dev libxml2 libxml2-dev libsasl2-dev libxslt-dev libxml2-dev libpq-dev imagemagick libmagickcore-dev libmagickwand-dev
babushka 'impactdata:2.3.9.rails.nativelibs'

#Install Ruby Enterprise 1.8.7 (suggest using RVM)
babushka 'impactdata:1.8.7.ee.rvm'

#Rails 2.3.9 + gems[bundler, heroku, thin, postgres, pgadmin3, mongodb]
babushka 'impactdata:2.3.9.rails.rvm'

#git clone git@github.com:ImpactData/Squawkbox.git
#cd Squawkbox
#git checkout development

#bundle install # installs gems from SB Gemfile

# Not sure all of these are necessary
#rake db:create
#rake db:create test
#rake db:migrate
#rake db:migrate test
#rake db:seed
#rake db:seed test
babushka 'impactdata:squawkbox.setup'




