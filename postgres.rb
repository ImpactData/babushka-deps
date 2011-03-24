
meta :aptget do
  def aptget args
    sudo("apt-get install #{args}")
  end
end

meta :pgadmin3 do
  def pgadmin3 args
    shell("pgadmin3 #{args}")
  end
end

meta :psql do
  def psql args
    shell("psql #{args}")
  end
end

dep 'postgres.native.access' do
  requires 'postgres.native', 'user exists'
  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{var :username}\b/).empty? }
  meet { sudo "createuser -SdR #{var :username}", :as => 'postgres' }
end

dep 'pgadmin3.native' do
    requires 'postgres.native'
    meet{ aptget("pgadmin3")}
    met?{ pgadmin3('--version') =~ /.*pgadmin3.*/ }
end

dep 'postgres.native' do
    meet { aptget("postgresql postgresql-client libpq-dev") }
    met? { psql('--version') =~ /.*psql.*/ ] }
end

