LIBRARIES = ['ruby-dev', 'libxml2-dev', 'libsasl2-dev', 'libxslt-dev', 'imagemagick', 'libmagickcore-dev',
                'libmagickwand-dev', 'libreadline-ruby', 'libmagickwand-dev', 'libreadline-ruby', 'libreadline5-dev',
                'memcached', 'libmemcached-dev', 'libmemcached-dbg']

dep '2.3.9.rails.nativelibs' do
  requires LIBRARIES.map{|lib| "#{lib}.aptget"}
end

LIBRARIES.each do |lib|
  dep "#{lib}.aptget" do
    meet{ aptget(lib)}
    met?{ aptget(lib) =~ /.*is already the newest version.*/ }
  end
end
