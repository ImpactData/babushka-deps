meta :rake do
  def rake args
    shell "rake #{args}", :log => args['install']
  end
end

dep 'squawkbox.setup' do
    requires 'squawkbox.bundle', 'migration.rake'    
end

dep 'squawkbox.bundle' do

    var(:rails_root, :default => "#{shell('pwd')}/Squawkbox")
    var(:home_root, :default => "#{shell('pwd')}")

  requires 'squawkbox.git', 'Gemfile', 'bundler.gem'
  requires_when_unmet Dep('current dir:packages')
  met? { in_dir(var(:rails_root)) { shell 'bundle check', :log => true } }
  meet { in_dir(var(:rails_root)) {
    install_args = var(:rails_env) != 'production' ? '' : "--deployment --without 'development test'"
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

    var(:rails_root, :default => "#{shell('pwd')}/Squawkbox")
    var(:home_root, :default => "#{shell('pwd')}")

    requires_when_unmet Dep('current dir:packages')
    before {
        shell("rm -rf #{var(:rails_root)}")
    }    
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





