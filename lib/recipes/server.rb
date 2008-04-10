namespace :server do
  desc <<-DESC
    sudo aptitude upgrade
  DESC
  task :update do
    run "sudo aptitude update"
  end
end