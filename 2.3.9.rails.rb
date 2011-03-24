meta :gem do
  def rvm args
    shell "gem #{args}", :log => args['install']
  end
end

dep '2.3.9.rails.enviro' do
    requires '2.3.9.rails.gems', 'bundler.gem', 'heroku.gem', 'thin.gem' 
end

dep '2.3.9.rails.gems' do
    met? { login_shell('gem list')['rails-2.3.9'] }
    meet { gem('install rails --VERSION=2.3.9 --include-dependencies') }
end 

dep 'bundler.gem' do
    met? { login_shell('gem list')['bundler'] }
    meet { gem('install bundler --VERSION=0.9.7') }
end

dep 'heroku.gem' do
    met? { login_shell('gem list')['heroku'] }
    meet { gem('install heroku') }
end

dep 'thin.gem' do
    met? { login_shell('gem list')['thin'] }
    meet { gem('install thin') }
end
