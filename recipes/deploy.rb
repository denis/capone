namespace :capone do
  namespace :deploy do
    desc <<-DESC
      Create MySQL user and database.
    DESC
    task :setup_db, :roles => :db, :only => { :primary => true } do
      run "echo 'Not implemented yet.'"
    end

    desc <<-DESC
      Install gems needed by application.
    DESC
    task :install_gems, :roles => :app do
      sudo "rake gems:install -f #{release_path}/Rakefile"
    end
  end
end

after "deploy:setup", "capone:deploy:setup_db"
after "deploy:update_code", "capone:deploy:install_gems"
