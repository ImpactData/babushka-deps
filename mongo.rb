dep 'mongo.start' do
  requires 'mongo.aptget'
  met?{ shell('mongo --version') =~ /.*MongoDB.*/ }
  after{
    sudo('mongod --repair')
    sudo('service mongodb start')
  }
end


