namespace :capone do
  namespace :db do
    desc <<-DESC
      Create MySQL user and database using data from config/database.yml.
    DESC
    task :setup, :roles => :db, :only => { :primary => true } do
      config = YAML::load(File.open("config/database.yml"))[rails_env]
      root_password = Capistrano::CLI.password_prompt(prompt="Enter a root password for MySQL: ")

      run "mysql --user='root' --password='#{root_password}' -e \"CREATE DATABASE IF NOT EXISTS #{config["database"]} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci; GRANT ALL PRIVILEGES ON #{config["database"]}.* TO '#{config["username"]}'@'localhost' IDENTIFIED BY '#{config["password"]}' WITH GRANT OPTION;\""
    end

    desc <<-DESC
      Load fixtures from db/fixtures to the database.
    DESC
    task :load_fixtures, :roles => :db, :only => { :primary => true } do
      run "rake db:fixtures:load FIXTURES_PATH=db/fixtures RAILS_ENV=#{rails_env} -f #{release_path}/Rakefile"
    end

    desc <<-DESC
      Dumps the database for the current environment into db/env-data.sql.bz2.
      Any existing backup will be overwritten.
    DESC
    task :backup, :roles => :db, :only => { :primary => true } do
      config = YAML::load(File.open("config/database.yml"))[rails_env]
      case config["adapter"]
        when "mysql"
          cmd = ["mysqldump"]
          cmd << "--host='#{config['host']}'" unless config["host"].nil?
          cmd << "--user='#{config['username'].nil? ? 'root' : config['username']}'"
          cmd << "--password='#{config['password']}'" unless config["password"].nil?
          cmd << config["database"]
          cmd << "| bzip2 > #{current_path}/db/#{rails_env}-data.sql.bz2"
          run cmd.join(" ")
      else
        puts "Task not supported by '#{config['adapter']}'."
      end
    end

    desc <<-DESC
      Dump the database for the current environment and take a local copy.
    DESC
    task :download_backup, :roles => :db, :only => { :primary => true } do
      backup
      get "#{current_path}/db/#{rails_env}-data.sql.bz2", "db/#{rails_env}-data.sql.bz2"
    end

    desc <<-DESC
      Load an existing database dump into the development environment's database.
    DESC
    task :load_backup do
      run_locally "rake db:drop"
      run_locally "rake db:create"

      config = YAML::load(File.open("config/database.yml"))[rails_env]
      case config["adapter"]
        when "mysql"
          cmd = ["bzcat db/#{rails_env}-data.sql.bz2 | mysql"]
          cmd << "--host='#{config['host']}'" unless config["host"].nil?
          cmd << "--user='#{config['username'].nil? ? 'root' : config['username']}'"
          cmd << "--password='#{config['password']}'" unless config["password"].nil?
          cmd << config["database"]
          run_locally cmd.join(" ")
      else
        puts "Task not supported by '#{config['adapter']}'."
      end
    end

    task :replicate do
      download_backup
      load_backup
    end
  end
end

on :load do
  if fetch(:setup_database_after_deploy_setup, true)
    after "deploy:setup", "capone:db:setup"
  end
  if fetch(:load_fixtures_to_database_after_deploy_cold, false)
    after "deploy:cold", "capone:db:load_fixtures"
  end

  if fetch(:backup_database_before_migrations, false)
    before "deploy:migrate", "capone:db:backup"
  end

  if fetch(:disable_web_during_migrations, false)
    before "deploy:migrations", "deploy:web:disable"
    after  "deploy:migrations", "deploy:web:enable"
  end
end

depend :remote, :command, "mysql"
depend :remote, :command, "mysqldump"
depend :remote, :command, "bzip2"
