def set_paths 
    var(:home_root, :default => "#{shell('pwd')}")
    var(:rails_root, :default => "#{var(:home_root)}/Squawkbox")
end

dep 'squawkbox_setup' do
    requires 'squawkbox_bundle', 'rvmrc'    
    log "Upon successfully installation of sqauwkbox"
	log "cd Squawkbox"
    log "rake db:create"
    log "rake db:create test"
    log "rake db:migrate"
    log "rake db:migrate test"
    log "rake db:seed"
    log "rake db:seed test"	
end

dep 'rvmrc' do 
	met? {
		shell("ls ~/Squawkbox/.rvmrc") =~ /.*\.rvmrc.*/
	}
    meet {
		shell("echo \"ree-1.8.7-head\" > ~/Squawkbox/.rvmrc")
	}
end

dep 'squawkbox_bundle' do

  set_paths()

  requires 'squawkbox_git', 'Gemfile'
  requires_when_unmet Dep('current dir:packages')
  met? { in_dir(var(:rails_root)) { shell 'bundle check', :log => true } }
  meet { in_dir(var(:rails_root)) {
    install_args = var(:rails_env, :default => "development") != 'production' ? '' : "--deployment --without 'development test'"
    unless shell("bundle install #{install_args}", :log => true)
      confirm("Try a `bundle update`") {
        shell 'bundle update', :log => true
      }
    end
  } }
end

dep 'Gemfile' do
  met? { (var(:rails_root) / 'Gemfile').exists? }
end

dep 'squawkbox_git' do

    set_paths()
    
    requires_when_unmet Dep('current dir:packages')
        
    meet {
        in_dir(var(:home_root)){
            git("clone git@github.com:ImpactData/Squawkbox.git")
        }
    }
    met? {
        shell("ls #{var(:rails_root)}") != nil    
    }
    after {
        in_dir(var(:rails_root)){
            git("checkout development")
        }
    } 
end








