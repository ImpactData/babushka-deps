#!/bin/sh
#for both production and staging
sudo mongodump -h swan.mongohq.com:27114 -d app438149 -u heroku -p dzmszgwbcvsl8rhxtqp9rl -o /backup/mongo
sudo mongodump -h pearl.mongohq.com:27091 -d app457548 -u heroku -p 1tcvkdn5otepg06t6u5zdp -o /backup/mongo
