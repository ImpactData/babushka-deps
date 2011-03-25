dep 'git_setup' do
    requires 'git_username', 'git_email'    
end

dep 'git_username' do
    meet{ 
        shell("git config --global user.name \"#{var :git_username}\"")
    }
    met?{
        shell("git config --get user.name") == "#{var :git_username}"
    }    
end

dep 'git_email' do
    meet{ 
        shell("git config --global user.email \"#{var :git_email}\"")
    }
    met?{
        shell("git config --get user.email") == "#{var :git_email}"
    }    
end

