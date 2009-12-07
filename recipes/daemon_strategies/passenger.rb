namespace :deploy do
  desc "Start application."
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc "Stop application."
  task :stop, :roles => :app do
  end

  desc "Restart application."
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

depend :remote, :gem, "passenger", ">=2.2.2"
