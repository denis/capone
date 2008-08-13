require "mongrel_cluster/recipes"

set :application, "set your application name here"
set :repository,  "someuser@somehost:git/#{application}.git"
set :scm, :git

set :user, "deploy"
set :use_sudo, false

set :deploy_to, "/var/www/apps/#{application}"

set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"

role :app, "your app-server here", :cron => true
role :web, "your web-server here"
role :db,  "your db-server here", :primary => true
