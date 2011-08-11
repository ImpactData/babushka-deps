dep 'rsyslog.aptget' do
    log("vi /etc/rsyslog.conf")
    log("uncomment $ModLoad imtcp")
    log("uncomment $InputTCPServerRun 514")
    log("services rsyslog stop")
    log("services rsyslog start")
    meet { aptget('rsyslog') }
    met? { aptget('rsyslog') =~ /.*rsyslog is already the newest version.*/ }
end
