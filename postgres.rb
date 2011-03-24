#hacked from benhoskings:postgres creds
dep 'existing postgres db' do
  requires 'postgres access'
  met? {
    !shell("psql -l") {|shell|
      shell.stdout.split("\n").grep(/^\s*#{var :db_name}\s+\|/)
    }.empty?
  }
  meet {
    shell "createdb -O '#{var :username}' '#{var :db_name}'"
  }
end

dep 'existing data' do
  requires 'existing db'
  met? {
    shell("psql #{var(:db_name)} -c '\\d'").scan(/\((\d+) rows?\)/).flatten.first.tap {|rows|
      if rows && rows.to_i > 0
        log "There are already #{rows} tables."
      else
        unmeetable <<-MSG
That database is empty. Load a database dump with:
$ cat #{var(:db_name)} | ssh #{var(:username)}@#{var(:domain)} 'psql #{var(:db_name)}'
        MSG
      end
    }
  }
end

dep 'pg.gem' do
  requires 'postgres.managed'
  provides []
end

dep 'postgres access' do
  requires 'postgres.managed', 'user exists'
  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{var :username}\b/).empty? }
  meet { sudo "createuser -SdR #{var :username}", :as => 'postgres' }
end

dep 'pgadmin3.managed' do
    requires 'postgres.managed'
    meet{sudo("apt-get install pgadmin3")}
    met?{ login_shell('pgadmin3 --version')['pgadmin3'] }   
end

dep 'postgres.managed' do
  meet { sudo("apt-get install postgresql postgresql-client libpq-dev") }
  met?{ login_shell('psql --version')['psql'] }
}
end

