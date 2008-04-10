namespace :capone do
  namespace :backup do
    desc <<-DESC
      Backup MySQL databases
    DESC
    task :mysql do
      run "ls"
    end
  end
end
