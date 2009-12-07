namespace :capone do
  namespace :gems do
    desc <<-DESC
      Install gems needed by application.
    DESC
    task :install, :roles => :app do
      run "rake gems:install -f #{release_path}/Rakefile RAILS_ENV=#{rails_env}"
    end

    desc <<-DESC
      Update installed gems.
    DESC
    task :update, :roles => :app do
      sudo "gem update --no-rdoc --no-ri"
    end
  end
end

on :load do
  if fetch(:install_gems, true)
    after "deploy:update_code", "capone:gems:install"
  end
end
