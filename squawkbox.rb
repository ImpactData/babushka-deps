meta :rake do
  def rake args
    shell "rake #{args}", :log => args['install']
  end
end

def set_paths 
    var(:home_root, :default => "#{shell('pwd')}")
    var(:rails_root, :default => "#{var(:home_root)}/Squawkbox")
end

dep 'squawkbox.setup' do
    requires 'squawkbox.bundle', 'migration.rake'    
end

dep 'squawkbox.bundle' do

  set_paths()

  requires 'squawkbox.git', 'Gemfile'
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

dep 'squawkbox.git' do

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

dep 'migration.rake' do

    set_paths()

    before {
        in_dir("#{var(:rails_root)}/config"){
            settings = YAML::load_file('database.yml')
            settings["development"]     
        }
    }
    meet {
        in_dir(var(:rails_root)){
            rake 'db:create'
            rake 'db:create test'
            rake 'db:migrate'
            rake 'db:migrate test'
            rake 'db:seed'
            rake 'db:seed test'
        }
    }
end





