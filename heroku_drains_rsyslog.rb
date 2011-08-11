dep 'rsyslog.aptget' do
    meet { aptget('rsyslog') }
    met? { aptget('rsyslog') =~ /.*rsyslog is already the newest version.*/ }
end
