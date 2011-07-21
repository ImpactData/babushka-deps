dep 'install_team_city' do
    requires 'team_city_install_file_unzip', 'team_city_install_openJDK.aptget'
    meet { shell('~/TeamCity/bin/runAll.sh start') }
end

dep 'team_city_install_file_unzip' do
    meet { shell('tar -zxvf TeamCity-17132.tar.gz') }
    met? { shell('ls TeamCity') =~ /.*TeamCity.*/ }
end

dep 'team_city_install_openJDK.aptget' do
    meet { aptget('openjdk-6-jre-headless') }
    met? { shell('java -version') =~ /.*OpenJDK Runtime Environment.*/ }
end

