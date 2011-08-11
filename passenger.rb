dep 'install_nginx_passenger.aptget' do
  requires 'add_passenger_brightbox_repo'
  
  met?{ aptget('-y install nginx-brightbox') =~ /.*is already the newest version.*/ }
  meet{ aptget('-y install nginx-brightbox')  }
  after {
    log('Edit your Nginx configuration file')
    log('http {')
    log(' ...')
    log('  passenger_root /home/ubuntu/.rvm/gems/ree-1.8.7-2011.03/gems/passenger-3.0.7;')
    log('  passenger_ruby /home/ubuntu/.rvm/wrappers/ree-1.8.7-2011.03/ruby;')
    log(' ...')
    log('}')
    log(' server {')
    log('   listen       80;')
    log('   server_name  heroku.impactdata.com.au;')
    log('   root /home/ubuntu/Squawkbox/public;')
    log('    passenger_enabled on;')
  }
end

dep 'add_passenger_brightbox_repo' do
    met?{
        shell("cat /etc/apt/sources.list.d/brightbox.list") =~ /.*apt.brightbox.net.lucid.main.*/
    }
    meet{
        if shell("echo $HOME") =~ /.*root.*/ 
            shell("sh -c `wget sh -c 'wget -q -O - http://apt.brightbox.net/release.asc | apt-key add -'`")
            shell('echo "deb http://apt.brightbox.net lucid main" | sudo tee --append /etc/apt/sources.list.d/brightbox.list')
            shell('apt-get update')  
        else
            sudo("sh -c `wget sh -c 'wget -q -O - http://apt.brightbox.net/release.asc | apt-key add -'`")
            sudo('echo "deb http://apt.brightbox.net lucid main" | sudo tee --append /etc/apt/sources.list.d/brightbox.list')
            sudo('apt-get update')
        end
    }
end

