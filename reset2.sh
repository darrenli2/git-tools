pushd `dirname $0`
./switch_country.sh pirate
bundle exec rake payroll_local:install:migrations
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:reset
bundle exec rake db:migrate
bundle exec rake db:seed
popd
