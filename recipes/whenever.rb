namespace :capone do
  namespace :whenever do
    desc <<-DESC
      Update the crontab file with whenever.
    DESC
    task :update_crontab, :roles => :db do
      run "cd #{release_path} && whenever --update-crontab #{application}"
    end
  end
end

on :load do
  if fetch(:whenever, false)
    after "deploy:symlink", "capone:whenever:update_crontab"
  end
end
