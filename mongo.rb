meta :aptget do
  def aptget args
    sudo("apt-get install #{args}")
  end
end

dep 'mongo.aptget' do
    meet{ aptget('mongodb')['--fix-missing']}
    met?{ shell('mongo --version') =~ /.*MongoDB.*/ }
    after{
        aptget('mongodb')['--fix-missing']
    }
end 
