dep 'install_passenger.gem' do
  met?{ gem('list passenger') =~ /.*passenger.*/ }
  meet{ gem('install passenger') }
  after {
    log('run passenger-install-nginx-module')
    log('install to /home/<user>/nginx')
    log('Edit your Nginx configuration file')
    log('vi /home/<user>/nginx/conf/nginx.conf')
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


