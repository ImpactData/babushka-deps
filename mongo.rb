
dep 'mongo.aptget' do
    meet{ aptget('mongodb')['--fix-missing']}
    met?{ shell('mongo --version') =~ /.*MongoDB.*/ }
    after{
        aptget('mongodb')['--fix-missing']
    }
end 
