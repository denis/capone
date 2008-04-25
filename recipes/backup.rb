namespace :capone do
  namespace :backup do
    desc <<-DESC
      Backup all.
    DESC
    task :default do
      mysql
    end

    desc <<-DESC
      Backup MySQL database.
    DESC
    task :mysql, :roles => :db, :only => { :primary => true } do
      run "echo 'Not implemented yet.'"
    end
  end
end
