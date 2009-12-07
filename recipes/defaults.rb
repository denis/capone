set :scm, :git
set :deploy_via, :remote_cache

set :rails_env, "production"

set(:deploy_to) { "/var/www/apps/#{application}" }

role(:app) { host }
role(:web) { host }
role(:db, :primary => true) { host }

set :use_sudo, false

# Needed for proper password prompts
default_run_options[:pty] = true

# You can redefine these variables in your config/deploy.rb

# set :daemon_strategy, :mongrel_cluster
# set :web_server, :nginx

# set :install_gems, true

# set :backup_database_before_migrations, false
# set :disable_web_during_migrations, false
# set :setup_database_after_deploy_setup, true
# set :load_fixtures_to_database_after_deploy_cold, false

# set :whenever, false
# set :delayed_job, false
