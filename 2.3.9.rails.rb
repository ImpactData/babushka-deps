meta :gem do
  def gem args
   if shell('echo $HOME') =~ /.*root.*/
       shell "~/.rvm/bin/rvm use ree && ~/.rvm/rubies/ree-1.8.7-2011.03/bin/gem #{args}", :log => args['install']
   else
       shell "/usr/local/rvm/bin/rvm use ree && /usr/local/rvm/rubies/ree-1.8.7-2011.03/bin/gem #{args}", :log => args['install']
   end
  end
end

meta :aptget do
  def aptget args
    sudo("apt-get --assume-yes install #{args}")
  end
end

dep 'rubygems.aptget' do
    meet{ aptget('rubygems1.8')}
    met?{ aptget('rubygems1.8') =~ /.*is already the newest version.*/ }
end 

dep '2.3.9.rails.rvm' do
    #log("set rvm ruby version")
    #rvm('~/.rvm/bin/rvm use ree')
    requires 'rubygems.aptget', '2.3.9.rails.gem', 'bundler.gem', 'heroku.gem', 'thin.gem', 'postgres.gem', 'mongo.aptget' 
end

dep '2.3.9.rails.gem' do
    met? { gem('list rails') =~ /.*rails \(2\.3\.9\).*/ }
    meet { gem('install rails --VERSION=2.3.9 --include-dependencies') }
end 

dep 'postgres.gem' do
    requires 'postgres.access'
    met? { gem('list postgres')['postgres'] }
    meet { gem('install postgres') }
end

dep 'bundler.gem' do
    requires 'rubygems_update.gem'
    met? { gem('list bundler')['bundler'] }
    meet { 
	shell('gem install bundler') 
    }
end

dep 'rubygems_update.gem' do
    met? { gem('list rubygems-update')['rubygems-update'] }
    meet { gem('install rubygems-update') }
end

dep 'heroku.gem' do
    met? { gem('list heroku')['heroku'] }
    meet { gem('install heroku') }
end

dep 'thin.gem' do
    met? { gem('list thin')['thin'] }   
    meet { gem('install thin') }
end

