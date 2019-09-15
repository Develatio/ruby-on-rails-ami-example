#!/usr/bin/env bash

# WARNING: This script will be executed as the "admin" user.
# If you want to run it as another user, use su/sudo.

cd /var/www/webapp/src

setfacl -R -d -m u:admin:rwx ./tmp ./log
setfacl -R -d -m g:www-data:rwx ./tmp ./log
setfacl -R -d -m o::r-x ./tmp ./log

setfacl -R -m u:admin:rwx ./tmp ./log
setfacl -R -m g:www-data:rwx ./tmp ./log
setfacl -R -m o::r-x ./tmp ./log

# Install some dependencies
bundle install
yarn install --check-files

# Maybe collect statics?
#RAILS_ENV=production rails assets:precompile

# Maybe run migrations?
#RAILS_ENV=production rails db:migrate

# We want to restart Passenger after installing our dependencies
sudo systemctl restart passenger