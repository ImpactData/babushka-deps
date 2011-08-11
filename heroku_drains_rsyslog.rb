dep 'rsyslog.aptget' do
    meet { aptget('rsyslog') }
    met? { aptget('rsyslog') =~ /.*bison is already the newest version.*/ }
end
