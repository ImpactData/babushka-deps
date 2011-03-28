dep '2.3.9.rails.nativelibs' do
    #requires 'rubydev.managed', 'libxml2dev.managed', 'libsasl2dev.managed' ,'libxsltdev.managed', 'libxml2dev.managed', 'imagemagick.managed', 'libmagickcoredev.managed', 'libmagickwanddev.managed'
    requires 'rubydev.aptget', 'libxml2dev.aptget', 'libsasl2dev.aptget' ,'libxsltdev.aptget', 'libxml2dev.aptget', 'imagemagick.aptget', 'libmagickcoredev.aptget', 'libmagickwanddev.aptget'
end

#dep 'rubydev.managed' do
#    installs{ via :apt, 'ruby-dev'}
#    provides []
#end 

dep 'rubydev.aptget' do
    meet{ aptget('ruby-dev')}
    met?{ aptget('ruby-dev') =~ /.*ruby-dev is already the newest version.*/ }
end 

#dep 'libxml2dev.managed' do
#    installs { via :apt ,'libxml2-dev'}
#    provides []
#end

dep 'libxml2dev.aptget' do
    meet{ aptget('libxml2-dev')}
    met?{ aptget('libxml2-dev') =~ /.*libxml2-dev is already the newest version.*/ }
end 

#dep 'libsasl2dev.managed' do
#    installs { via :apt, 'libsasl2-dev' }
#    provides []
#end 

dep 'libsasl2dev.aptget' do
    meet{ aptget('libsasl2-dev')}
    met?{ aptget('libsasl2-dev') =~ /.*libsasl2-dev is already the newest version.*/ }
end 

#dep 'libxsltdev.managed' do
#    installs { via :apt, 'libxslt-dev' }
#    provides []
#end 

dep 'libxsltdev.aptget' do
    meet{ aptget('libxslt-dev')}
    met?{ aptget('libxslt-dev') =~ /.*libxslt1-dev is already the newest version.*/ }
end 

#dep 'libxml2dev.managed' do
#    installs { via :apt, 'libxml2-dev' }
#    provides []
#end 

dep 'libxml2dev.aptget' do
    meet{ aptget('libxml2-dev')}
    met?{ aptget('libxml2-dev') =~ /.*libxml2-dev is already the newest version.*/ }
end 

#dep 'imagemagick.managed' do
#    installs { via :apt, 'imagemagick' }
#    provides []
#end 

dep 'imagemagick.aptget' do
    meet{ aptget('imagemagick')}
    met?{ aptget('imagemagick') =~ /.*imagemagick is already the newest version.*/ }
end 

#dep 'libmagickcoredev.managed' do
#    installs { via :apt, 'libmagickcore-dev' }
#    provides []
#end 

dep 'libmagickcoredev.aptget' do
    meet{ aptget('libmagickcore-dev')}
    met?{ aptget('libmagickcore-dev') =~ /.*libmagickcore-dev is already the newest version.*/ }
end 

#dep 'libmagickwanddev.managed' do
#  installs { via :apt, 'libmagickwand-dev' }
#  provides []
#end

dep 'libmagickwanddev.aptget' do
    meet{ aptget('libmagickwand-dev')}
    met?{ aptget('libmagickwand-dev') =~ /.*libmagickwand-dev is already the newest version.*/ }
end 
