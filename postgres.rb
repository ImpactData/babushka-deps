dep 'postgres.native.access' do
  requires 'postgres.managed', 'user exists'
  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{var :username}\b/).empty? }
  meet { sudo "createuser -SdR #{var :username}", :as => 'postgres' }
end

dep 'pgadmin3.native' do
    requires 'postgres.managed'
    meet{sudo("apt-get install pgadmin3")}
end

dep 'postgres.native' do
  meet { sudo("apt-get install postgresql postgresql-client libpq-dev") }
end

