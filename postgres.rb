
meta :aptget do
  def aptget args
    sudo("apt-get install #{args}")
  end
end

dep 'postgres.native.access' do
  requires 'postgres.native', 'user exists'
  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{var :username}\b/).empty? }
  meet { sudo "createuser -SdR #{var :username}", :as => 'postgres' }
end

dep 'pgadmin3.aptget' do
    requires 'postgres.aptget'
    meet{ aptget("pgadmin3")}
    met?{ shell('pgadmin3 -h') =~ /.*pgadmin3.*/ }
end

dep 'postgres.aptget' do
    meet { aptget("postgresql postgresql-client libpq-dev") }
    met? { shell('psql --version') =~ /.*psql.*/  }
end

