namespace :remote do
  desc <<-DESC
    sudo aptitude upgrade
  DESC
  task :update do
    sudo "aptitude update"
  end
end