pushd `dirname $0`
./switch_country.sh ca
bundle exec rake payroll_local:install_migrations
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:reset
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake payroll_local:update_remittance_authorities
popd