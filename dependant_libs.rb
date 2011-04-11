dep '2.3.9.rails.nativelibs' do
    #requires 'rubydev.managed', 'libxml2dev.managed', 'libsasl2dev.managed' ,'libxsltdev.managed', 'libxml2dev.managed', 'imagemagick.managed', 'libmagickcoredev.managed', 'libmagickwanddev.managed'
    requires 'rubydev.aptget', 'libxml2dev.aptget', 'libsasl2dev.aptget' ,'libxsltdev.aptget', 'libxml2dev.aptget', 'imagemagick.aptget', 'libmagickcoredev.aptget', 'libmagickwanddev.aptget', 'libreadline_ruby.aptget', 'memcached.aptget'
end

dep 'rubydev.aptget' do
    meet{ aptget('ruby-dev')}
    met?{ aptget('ruby-dev') =~ /.*is already the newest version.*/ }
end 

dep 'libxml2dev.aptget' do
    meet{ aptget('libxml2-dev')}
    met?{ aptget('libxml2-dev') =~ /.*is already the newest version.*/ }
end 

dep 'libsasl2dev.aptget' do
    meet{ aptget('libsasl2-dev')}
    met?{ aptget('libsasl2-dev') =~ /.*is already the newest version.*/ }
end 

dep 'libxsltdev.aptget' do
    meet{ aptget('libxslt-dev')}
    met?{ aptget('libxslt-dev') =~ /.*is already the newest version.*/ }
end 

dep 'libxml2dev.aptget' do
    meet{ aptget('libxml2-dev')}
    met?{ aptget('libxml2-dev') =~ /.*is already the newest version.*/ }
end 

dep 'imagemagick.aptget' do
    meet{ aptget('imagemagick')}
    met?{ aptget('imagemagick') =~ /.*is already the newest version.*/ }
end 

dep 'libmagickcoredev.aptget' do
    meet{ aptget('libmagickcore-dev')}
    met?{ aptget('libmagickcore-dev') =~ /.*is already the newest version.*/ }
end 

dep 'libmagickwanddev.aptget' do
    meet{ aptget('libmagickwand-dev')}
    met?{ aptget('libmagickwand-dev') =~ /.*is already the newest version.*/ }
end 

dep 'libreadline_ruby.aptget' do
    meet { aptget('libreadline-ruby')}
    met?{ aptget('libreadline-ruby') =~ /.*is already the newest version.*/ }
end

dep 'libreadline5dev.aptget' do
    meet { aptget('libreadline5-dev')}
    met?{ aptget('libreadline5-dev') =~ /.*is already the newest version.*/ }
end

dep 'memcached.aptget' do 
	meet { aptget('memcached') }
	met?{ aptget('memcached') =~ /.*is already the newest version.*/ }
end


