meta :gem do
  def gem args
    sudo "gem #{args}", :log => args['install']
  end
end

meta :aptget do
  def aptget args
    sudo("apt-get install #{args}")
  end
end

dep '2.3.9.rails' do
    requires '2.3.9.rails.gem', 'bundler.gem', 'heroku.gem', 'thin.gem', 'postgres.gem', 'mongo.aptget' 
end

dep '2.3.9.rails.gem' do
    requires_when_unmet Dep('current dir:packages')   
    set_paths() 
    met? { 
        in_dir(var(:rails_root)) {
            gem('list rails')['rails (2.3.9)'] 
        }
    }
    meet { 
        in_dir(var(:rails_root)) {
            gem('install rails --VERSION=2.3.9 --include-dependencies') 
        }
    }
end 

dep 'postgres.gem' do
    requires_when_unmet Dep('current dir:packages')    
    set_paths()
    requires 'postgres.access'
    met? { gem('list postgres')['postgres'] }
    meet { gem('install postgres') }
end

dep 'bundler.gem' do
    requires_when_unmet Dep('current dir:packages')    
    set_paths()    
    requires 'rubygems_update.gem'
    met? { 
        in_dir(var(:rails_root)) {
            gem('list bundler')['bundler'] 
        }
    }
    meet { 
        in_dir(var(:rails_root)) {
            gem('install bundler') 
        }
    }
end

dep 'rubygems_update.gem' do
    requires_when_unmet Dep('current dir:packages')    
    set_paths()
    met? { 
        in_dir(var(:rails_root)) {
            gem('list rubygems-update')['rubygems-update'] 
        }
    }
    meet { 
        in_dir(var(:rails_root)) {
            gem('install rubygems-update') 
        }
    }
end

dep 'heroku.gem' do
    requires_when_unmet Dep('current dir:packages')    
    set_paths()
    met? {
        in_dir(var(:rails_root)) { 
            gem('list heroku')['heroku'] 
        }
    }
    meet { 
        in_dir(var(:rails_root)) {
            gem('install heroku') 
        }
    }
end

dep 'thin.gem' do
    requires_when_unmet Dep('current dir:packages')    
    set_paths()
    met? { 
        in_dir(var(:rails_root)) {
            gem('list thin')['thin'] 
        }
    }   
        
    meet { 
        in_dir(var(:rails_root)) {
            gem('install thin') 
        }
    }
end

