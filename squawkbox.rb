def set_paths 
    var(:home_root, :default => "#{shell('pwd')}")
    var(:rails_root, :default => "#{var(:home_root)}/Squawkbox")
end

dep 'squawkbox_setup' do
    requires 'squawkbox_bundle', 'rvmrc'    
    log "Upon successfully installation of sqauwkbox"
    log "cd Squawkbox"
    log "change hosts file to include; 0.0.0.0 development"
    log "edit nginx.conf"
    log "server {"
    log "    listen    3000;"
    log "    server_name development;"
    log "    root      /<location>/squawkbox/public;"
    log "    rails_env development;"
    log "    passenger_enabled on;"
    log "}"
    
end

dep 'rvmrc' do 
	met? {
		shell("ls ~/Squawkbox/.rvmrc") =~ /.*\.rvmrc.*/
	}
        meet {
		shell("echo \"rvm use ree\" > ~/Squawkbox/.rvmrc")
	}
end

dep 'squawkbox_bundle' do

  set_paths()

  requires 'squawkbox_git'
  requires_when_unmet Dep('current dir:packages')

 	met? { 
        	cd(var(:rails_root)) { 
			shell('bundle check') =~ /.*The Gemfile's dependencies are satisfied.*/ 
		} 
	}
  	meet { 
		cd(var(:rails_root)) {
			install_args = var(:rails_env, :default => "development") != 'production' ? '' : "--deployment --without 'development test'"
			shell("bundle install #{install_args}")
  		}	 
	}
end

dep 'squawkbox_git' do

    set_paths()
    
    requires_when_unmet Dep('current dir:packages')
        
    meet {
        shell("cd #{var :home_root} && git clone git@github.com:ImpactData/Squawkbox.git")
    }
    met? {
        shell("ls #{var(:rails_root)}") != nil    
    }
    after {
         shell("cd #{var :rails_root} && git checkout development")
    } 
end








