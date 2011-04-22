meta :gem do
  def gem args
    sudo "~/.rvm/rubies/ree-1.8.7-2011.03/bin/gem #{args}", :log => args['install']
  end
end

meta :aptget do
  def aptget args
    sudo "apt-get --assume-yes install #{args}"
  end
end

dep '2.3.9.rails' do
  requires '2.3.9.rails.gem', 'bundler.gem', 'heroku.gem', 'thin.gem', 'postgres.gem', 'mongo.aptget'
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
  requires 'rubygems-update.gem'
  met? { gem('list bundler')['bundler'] }
  meet {
    log "bundler is not a happy camper"
    log "you may have to do this manually"
    log "rvm use ree-1.8.7-2011.03"
    log "gem install bundler"
    shell('rvm use ree-1.8.7-2011.03')
    shell('gem install bundler')
  }
end

GEMS = ['rubygems-update', 'heroku', 'thin'].each do |gem|
  dep "#{gem}.gem" do
    met? { gem("list #{gem}")[gem] }
    meet { gem("install #{gem}") }
  end
end

