dep 'postgres.access' do
  requires 'libpqdev.aptget'

  log "Add Default User Access"

  sudo "useradd #{var :postgres_username, :default => 'torsion'}"  
  sudo "createuser -SdR #{var :postgres_username, :default => 'torsion'}", :as => 'postgres'

  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{var :postgres_username, :default => 'torsion'}\b/).empty? }
  meet { 
    sudo "psql -U postgres -c \"ALTER USER #{var :postgres_username, :default => 'torsion'} WITH PASSWORD '#{var :postgres_password, :default => 'torsion'}';\"", :as => 'postgres' 
    sudo "psql -U postgres -c \"CREATE DATABASE #{var :postgres_username, :default => 'torsion'};", :as => 'postgres'
    sudo "psql -U postgres -c \"GRANT ALL PRIVILEGES ON DATABASE #{var :postgres_username, :default => 'torsion'} TO '#{var :postgres_username, :default => 'torsion'}';\"", :as => 'postgres'
  }
end

dep 'libpqdev.aptget' do
    requires 'postgres.aptget'
    meet{ aptget("libpq-dev")}
    met?{ shell('ls /usr/include/postgresql/libpq') == "libpq-fs.h" }
end 

dep 'postgres.aptget' do
    requires 'add_postgres_9_repo'
    meet { 
      sudo("apt-get purge postgresql*")
      aptget("postgresql-9.0 libpq-dev") 
    }
    met? { shell('psql --version') =~ /.*9.*/  }
end

dep 'add_postgres_9_repo' do
    meet {
       sudo('apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8683D8A2')
       sudo('echo "deb http://ppa.launchpad.net/pitti/postgresql/ubuntu lucid main"  | sudo tee --append /etc/apt/sources.list')
       sudo('echo "deb-src http://ppa.launchpad.net/pitti/postgresql/ubuntu lucid main"  | sudo tee --append /etc/apt/sources.list')
       sudo('apt-get update')
    }    
    met?{
         shell('grep "deb http://ppa.launchpad.net/pitti/postgresql/ubuntu lucid main" /etc/apt/sources.list') =~ /.*pitti.*/
    }
end 

