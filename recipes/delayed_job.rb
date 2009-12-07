on :load do
  if fetch(:delayed_job, false)
    after "deploy:stop",    "delayed_job:stop"
    after "deploy:start",   "delayed_job:start"
    after "deploy:restart", "delayed_job:restart"
  end
end
