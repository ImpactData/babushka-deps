RAILS_LIBRARIES = ['ruby-dev', 'libxml2-dev', 'libsasl2-dev', 'libxslt-dev', 'imagemagick', 'libmagickcore-dev',
                'libmagickwand-dev', 'libreadline-ruby', 'libmagickwand-dev', 'libreadline-ruby', 'libreadline5-dev',
                'memcached', 'libmemcached-dev', 'libmemcached-dbg']

MONGO_LIBRARIES = ['mongodb']

POSTGRES_LIBRARIES = ['postgresql','postgresql-client','libpq-dev']

OTHER_LIBRARIES = ['zsh', 'bison']

LIBRARIES = (RAILS_LIBRARIES + MONGO_LIBRARIES + POSTGRES_LIBRARIES + OTHER_LIBRARIES)

dep '2.3.9.rails.nativelibs' do
  requires RAILS_LIBRARIES.map{|lib| "#{lib}.aptget"}
end

LIBRARIES.each do |lib|
  dep "#{lib}.aptget" do
    meet{ aptget(lib)}
    met?{ aptget(lib) =~ /.*is already the newest version.*/ }
  end
end
