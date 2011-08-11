#!/bin/sh
#restore postres database
pg_restore --verbose --clean --no-acl --no-owner --no-password -h 127.0.0.1 -U torsion -d torsion /backup/postgresql/freshest.dump
sudo service postgresql stop
sudo service postgresql start
