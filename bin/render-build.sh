#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:migrate:reset
bundle exec rails db:seed
