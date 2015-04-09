pushd `dirname $0`
./switch_country.sh ca
be rake payroll_local:install_migrations
be rake db:drop
be rake db:create
be rake db:reset
be rake db:migrate
be rake db:seed
be rake payroll_local:update_remittance_authorities
popd