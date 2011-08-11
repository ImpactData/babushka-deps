dep 'rsyslog.aptget' do
    log("see http://devcenter.heroku.com/articles/logging")
    log("vi /etc/rsyslog.conf")
    log("uncomment $ModLoad imtcp")
    log("uncomment $InputTCPServerRun 514")
    log("change $FileOwner adm")
    log("change $FileGroup adm")
    log("change $FileCreateMode 0640")
    log("change $DirCreateMode 0755")
    log("change $Umask 0022")
    log("change $PrivDropToUser adm")
    log("change $PrivDropToGroup adm")
    log("services rsyslog stop")
    log("services rsyslog start")
    meet { aptget('rsyslog') }
    met? { aptget('rsyslog') =~ /.*rsyslog is already the newest version.*/ }
end
