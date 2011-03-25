
meta :aptget do
  def aptget args
    sudo("apt-get install #{args}")
  end
end

dep 'postgres.access' do
  requires 'pgadmin3.aptget', 'libpqdev.aptget'
  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{var :username}\b/).empty? }
  meet { 
    sudo "createuser -SdR #{var :postgres_username}", :as => 'postgres' 
    sudo "psql -U postgres -c \"ALTER USER #{var :postgres_username} WITH PASSWORD '#{var :postgres_password}'\"", :as => 'postgres' 
    #sudo -u postgres psql -U postgres -c "ALTER USER postgres WITH PASSWORD 'elvis'"
  }
end

dep 'libpqdev.aptget' do
    requires 'postgres.aptget'
    meet{ aptget("libpq-dev")}
    met?{ shell('ls /usr/include/postgresql/libpq') == "libpq-fs.h" }
end 

dep 'pgadmin3.aptget' do
    requires 'postgres.aptget'
    meet{ aptget("pgadmin3")}
    met?{ shell('ls /usr/bin/pgadmin3') == "/usr/bin/pgadmin3" }
end

dep 'postgres.aptget' do
    meet { aptget("postgresql postgresql-client libpq-dev") }
    met? { shell('psql --version') =~ /.*psql.*/  }
end

