meta :git do
  def git args
    shell "git #{args}", :log => args['install']
  end
end

dep 'setup.git' do
    requires 'username.git', 'email.git'    
end

dep 'username.git' do
    meet{ 
        git("config --global user.name \"#{var :git_username}\"")
    }
    met?{
        git("config --get user.name") == "#{var :git_username}"
    }    
end

dep 'email.git' do
    meet{ 
        git("config --global user.email \"#{var :git_email}\"")
    }
    met?{
        git("config --get user.email") == "#{var :git_email}"
    }    
end

