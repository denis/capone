namespace :capone do
  namespace :deploy do
    desc <<-DESC
      Create MySQL user and database using data from config/database.yml.
    DESC
    task :setup_db, :roles => :db, :only => { :primary => true } do
      config = YAML::load(File.open("config/database.yml"))[rails_env]
      root_password = Capistrano::CLI.password_prompt(prompt="Enter a root password for MySQL: ")

      run "mysql -u root --password=#{root_password} -e \"CREATE DATABASE IF NOT EXISTS #{config["database"]} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci; GRANT ALL PRIVILEGES ON #{config["database"]}.* TO '#{config["username"]}'@'localhost' IDENTIFIED BY '#{config["password"]}' WITH GRANT OPTION;\""
    end

    desc <<-DESC
      Install gems needed by application.
    DESC
    task :install_gems, :roles => :app do
      run "rake gems:install -f #{release_path}/Rakefile RAILS_ENV=#{rails_env}"
    end

    desc <<-DESC
      Load fixtures from db/fixtures to the database
    DESC
    task :load_fixtures, :roles => :db, :only => { :primary => true } do
      run "rake db:fixtures:load FIXTURES_PATH=db/fixtures RAILS_ENV=#{rails_env} -f #{release_path}/Rakefile"
    end
  end
end
