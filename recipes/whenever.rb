# Original version of this file was excerpted from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
namespace :capone do
  namespace :whenever do
    desc <<-DESC
      Update the crontab file.
    DESC
    task :update_crontab, :roles => :db do
      run "cd #{release_path} && whenever --update-crontab #{application}"
    end
  end
end
