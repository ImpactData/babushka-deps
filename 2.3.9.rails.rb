dep '2.3.9.rails.enviro' do
    requires['2.3.9.rails', 'bundler.gem', 'heroku.gem', 'thin.gem']
end

dep '2.3.9.rails.gems' do
    met? { shell_log('gem list')['rails-2.3.9'] }
    meet { shell('gem install rails --VERSION=2.3.9 --include-dependencies') }
end 

dep 'bundler.gem' do
    met? { shell_log('gem list')['bundler'] }
    meet { shell('gem install bundler --VERSION=0.9.7') }
end

dep 'heroku.gem' do
    met? { shell_log('gem list')['heroku'] }
    meet { shell('gem install heroku') }
end

dep 'thin.gem' do
    met? { shell_log('gem list')['thin'] }
    meet { shell('gem install thin') }
end
