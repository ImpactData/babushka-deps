#!/bin/sh
#restore mongo database
mongorestore --db torsion-production /backup/mongo/app438149
sudo service mongodb stop
sudo service mongodb start