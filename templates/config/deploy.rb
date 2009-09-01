require "mongrel_cluster/recipes"
require "capone"

set :application, "set your application name here"
set :repository,  "someuser@somehost:git/#{application}.git"
set :scm, :git

set :user, "deploy"
set :use_sudo, false

set :deploy_to, "/var/www/apps/#{application}"

set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"

set :rails_env, "production"

role :app, "your app-server here"
role :web, "your web-server here"
role :db,  "your db-server here", :primary => true

after "deploy:setup",       "capone:deploy:setup_db"
after "deploy:update_code", "capone:deploy:install_gems"
# after "deploy:cold",        "capone:deploy:load_fixtures"

before "deploy:start",   "capone:nginx:enable_vhost"
after  "deploy:stop",    "capone:nginx:disable_vhost"
after  "deploy:restart", "capone:nginx:reload_if_config_file_changed"

# after "deploy:symlink", "capone:whenever:update_crontab"
