
dep 'mongo.aptget' do
    meet{ aptget('mongodb')}
    met?{ shell('mongo --version') =~ /.*MongoDB.*/ }
    after{
        aptget('mongodb')['--fix-missing']
    }
end 
