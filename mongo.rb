#http://wiki.mediatemple.net/w/(ve):Install_MongoDB_on_Ubuntu
dep 'mongo.aptget' do

    requires "mongo_add_10gen_mongo_repo"

    met?{ 
      sudo('service mongodb start')
      sudo('mongod --repair')
      shell('mongo --version') =~ /.*MongoDB.*/ 
    }
    meet{
      aptget('-y mongodb-stable')['--fix-missing']
      sudo('service mongodb start')
      sudo('mongod --repair')
    }
    
end 

dep "mongo_add_10gen_mongo_repo" do

    met?{
       shell("ls /etc/apt/sources.list.d/10gen.list") =~ /.*10gen.*/
    }
    meet{
       sudo("apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10")
       sudo("touch /etc/apt/sources.list.d/10gen.list")
       sudo('echo "deb http://downloads.mongodb.org/distros/ubuntu 10.4 10gen" >> /etc/apt/sources.list.d/10gen.list')
       sudo("apt-get update")
    }
    
end
