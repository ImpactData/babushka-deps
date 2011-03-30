#hacked from benhoskings:1.9.2.rvm creds
meta :rvm do
  def rvm args
    shell "sudo -u #{shell('whoami')} ~/.rvm/bin/rvm #{args}", :log => args['install']
  end
end

dep 'append_bashrc' do
	met? {		
		shell('grep rvm/scripts ~/.bashrc') =~ /.*rvm.scripts.*/
	} 
	meet {
		shell("echo '[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && . \"$HOME/.rvm/scripts/rvm\"' >> .bashrc")
	}
end

dep '1.8.7.ee.rvm' do
  requires '1.8.7.ee installed.rvm', 'append_bashrc'
  met? { login_shell('ruby --version')['ruby 1.8.7'] }
  meet { rvm('use ree-1.8.7-head') }
end

dep '1.8.7.ee installed.rvm' do
  requires ['rvm', 'bison.aptget']
  met? { rvm('list')['ree-1.8.7-head'] }
  meet { 
        log("installing ree_dependencies") { rvm('package install ree_dependencies')}
        log("installing ree-1.8.7-head") { rvm('install ree-1.8.7-head') } 
  }
end

#required yacc parser
dep 'bison.aptget' do
    meet { aptget('install bison') }
    met? { aptget('bison') =~ /.*bison is already the newest version.*/ }
end

dep 'rvm' do
  met? { raw_which 'rvm', login_shell('which rvm') }
  meet {
    if confirm("Install rvm system-wide?", :default => 'n')
      log_shell "Installing rvm using rvm-install-system-wide", 'bash < <( curl -L http://bit.ly/rvm-install-system-wide )'
    else
      log_shell "Installing rvm using rvm-install-head", 'bash -c "`curl http://rvm.beginrescueend.com/releases/rvm-install-head`"'
    end
  }
end

meta :rvm_mirror do
  def urls
    shell("grep '_url=' ~/.rvm/config/db").split("\n").reject {|l|
      l['_repo_url']
    }.map {|l|
      l.sub(/^.*_url=/, '')
    }
  end
  template {
    requires 'rvm'
  }
end

dep 'mirrored.rvm_mirror' do
  define_var :rvm_vhost_root, :default => '/srv/http/rvm'
  def missing_urls
    urls.tap {|urls| log "#{urls.length} URLs in the rvm database." }.reject {|url|
      path = var(:rvm_vhost_root) / url.sub(/^[a-z]+:\/\/[^\/]+\//, '')
      path.exists? && !path.empty?
    }.tap {|urls| log "Of those, #{urls.length} aren't present locally." }
  end
  met? { missing_urls.empty? }
  meet {
    missing_urls.each {|url|
      in_dir(var(:rvm_vhost_root) / File.dirname(url.sub(/^[a-z]+:\/\/[^\/]+\//, '')), :create => true) do
        # begin
          Babushka::Resource.download url
        # rescue StandardError => ex
        #   log_error ex.inspect
        # end
      end
    }
  }
  after {
    log urls.map {|url|
      url.scan(/^[a-z]+:\/\/([^\/]+)\//).flatten.first
    }.uniq.reject {|url|
      url[/[:]/]
    }.join(' ')
    log "Those are the domains you should point at #{var(:rvm_vhost_root)}."
  }
end
