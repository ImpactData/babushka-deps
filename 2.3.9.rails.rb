meta :gem do
  def gem args
    shell "gem #{args}", :log => args['install']
  end
end

meta :aptget do
  def aptget args
    sudo("apt-get install #{args}")
  end
end

dep '2.3.9.rails.enviro' do
    requires '2.3.9.rails.gem', 'bundler.gem', 'heroku.gem', 'thin.gem', 'postgres.gem', 'mongo.aptget' 
end

dep '2.3.9.rails.gem' do
    met? { login_shell('gem list rails')['rails (2.3.9)'] }
    meet { gem('install rails --VERSION=2.3.9 --include-dependencies') }
end 

dep 'postgres.gem' do
  requires 'postgres.access'
  met? { login_shell('gem list postgres')['postgres'] }
  meet { gem('install postgres') }
end

dep 'bundler.gem' do
    met? { login_shell('gem list bundler')['bundler (0.9.7)'] }
    meet { gem('install bundler --VERSION=0.9.7') }
end

dep 'heroku.gem' do
    met? { login_shell('gem list heroku')['heroku'] }
    meet { gem('install heroku') }
end

dep 'thin.gem' do
    met? { login_shell('gem list thin')['thin'] }
    meet { gem('install thin') }
end

dep 'rubydev.aptget' do
    meet{ aptget('ruby-dev')}
    met?{ aptget('ruby-dev') =~ /.*ruby-dev is already the newest version.*/ }
end 

#libxml2 libxml2-dev libsasl2-dev libxslt-dev libxml2-dev libpq-dev imagemagick libmagickcore-dev libmagickwand-dev


