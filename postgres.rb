dep 'postgres.access' do
  requires 'pgadmin3.aptget', 'libpq-dev.aptget'

  log "Defualt"

  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{var :username}\b/).empty? }
  meet { 
    sudo "createuser -SdR #{var :postgres_username, :default => 'torsion'}", :as => 'postgres' 
    sudo "psql -U postgres -c \"ALTER USER #{var :postgres_username, :default => 'torsion'} WITH PASSWORD '#{var :postgres_password, :default => 'torsion'}'\"", :as => 'postgres' 
    #sudo -u postgres psql -U postgres -c "ALTER USER postgres WITH PASSWORD 'elvis'"
  }
end

dep 'libpqdev.aptget' do
    requires 'postgres.libs'
    meet{ aptget("libpq-dev")}
    met?{ shell('ls /usr/include/postgresql/libpq') == "libpq-fs.h" }
end 

dep 'pgadmin3.aptget' do
    requires 'postgres.libs'
    meet{ aptget("pgadmin3")}
    met?{ shell('ls /usr/bin/pgadmin3') == "/usr/bin/pgadmin3" }
end

dep 'postgres.libs' do
    requires POSTGRES_LIBS.map{|lib| "#{lib}.aptget"}
    met? { shell('psql --version') =~ /.*psql.*/  }
end

