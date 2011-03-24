dep 'postgres.native.access' do
  requires 'postgres.native', 'user exists'
  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{var :username}\b/).empty? }
  meet { sudo "createuser -SdR #{var :username}", :as => 'postgres' }
end

dep 'pgadmin3.native' do
    requires 'postgres.native'
    meet{sudo("apt-get install pgadmin3")}
    met? {
        shell('pgadmin3 --version').include?('pgadmin3')
    }
end

dep 'postgres.native' do
    meet { sudo("apt-get install postgresql postgresql-client libpq-dev") }
    met? {
        shell('psql --version').include?('psql')
    }
end

