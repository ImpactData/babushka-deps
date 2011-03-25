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
    requires '1.8.7.ee.rvm', '2.3.9.rails.enviro.nativelibs', '2.3.9.rails.enviro.gems', 'mongo.aptget' 
end

dep '2.3.9.rails.enviro.gems' do
    requires '2.3.9.rails.gem', 'bundler.gem', 'heroku.gem', 'thin.gem', 'postgres.gem'
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

dep '2.3.9.rails.enviro.nativelibs' do
    requires 'rubydev.aptget', 'libxml2dev.aptget', 'libsasl2dev.aptget' ,'libxsltdev.aptget', 'libxml2dev.aptget', 'imagemagick.aptget', 'libmagickcoredev.aptget', 'libmagickwanddev.managed'
end

dep 'rubydev.aptget' do
    meet{ aptget('ruby-dev')}
    met?{ aptget('ruby-dev') =~ /.*ruby-dev is already the newest version.*/ }
end 

dep 'libxml2dev.aptget' do
    meet{ aptget('libxml2-dev')}
    met?{ aptget('libxml2-dev') =~ /.*libxml2-dev is already the newest version.*/ }
end 

dep 'libsasl2dev.aptget' do
    meet{ aptget('libsasl2-dev')}
    met?{ aptget('libsasl2-dev') =~ /.*libsasl2-dev is already the newest version.*/ }
end 

dep 'libxsltdev.aptget' do
    meet{ aptget('libxslt-dev')}
    met?{ aptget('libxslt-dev') =~ /.*libxslt1-dev is already the newest version.*/ }
end 

dep 'libxml2dev.aptget' do
    meet{ aptget('libxml2-dev')}
    met?{ aptget('libxml2-dev') =~ /.*libxml2-dev is already the newest version.*/ }
end 

dep 'imagemagick.aptget' do
    meet{ aptget('imagemagick')}
    met?{ aptget('imagemagick') =~ /.*imagemagick is already the newest version.*/ }
end 

dep 'libmagickcoredev.aptget' do
    meet{ aptget('libmagickcore-dev')}
    met?{ aptget('libmagickcore-dev') =~ /.*libmagickcore-dev is already the newest version.*/ }
end 

dep 'libmagickwanddev.managed' do
  installs { via :apt, 'libmagickwand-dev' }
  provides []
end

#dep 'libmagickwanddev.aptget' do
#    meet{ aptget('libmagickwand-dev')}
#    met?{ aptget('libmagickwand-dev') =~ /.*libmagickwand-dev is already the newest version.*/ }
#end 





