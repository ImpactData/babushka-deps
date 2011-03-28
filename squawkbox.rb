meta :rake do
  def rake args
    shell "rake #{args}", :log => args['install']
  end
end

meta :bundle do
  def bundle args
    shell "bundle #{args}", :log => args['install']
  end
end 

dep 'squawkbox.setup' do
    requires 'squawkbox.bundle'    
end

dep 'squawkbox.bundle' do
    requires 'squawkbox.git'
    meet {
        bundle("install")
    }
    met? {
        false
    }
end

dep 'squawkbox.git' do
    before {
        shell("cd ~")
        shell("rm -rf Squawkbox")
    }    
    meet {
        git("clone git@github.com:ImpactData/Squawkbox.git")
    }
    met? {
        shell("ls Squawkbox") == "Squawkbox"    
    }
    after {
        shell("cd Squawkbox")
        git("checkout development")
    } 
end

