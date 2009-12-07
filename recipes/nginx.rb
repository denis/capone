namespace :capone do
  namespace :nginx do
    desc <<-DESC
      Enable virtual host.
    DESC
    task :enable_vhost, :roles => :web do
      sudo "ln -fs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
      sudo "/etc/init.d/nginx reload"
    end

    desc <<-DESC
      Disable virtual host.
    DESC
    task :disable_vhost, :roles => :web do
      sudo "rm /etc/nginx/sites-enabled/#{application}"
      sudo "/etc/init.d/nginx reload"
    end

    desc <<-DESC
      Reload nginx configuration if the application nginx virtual host config file was changed.
    DESC
    task :reload_if_config_file_changed, :roles => :web do
      run "bash -c \"if ! cmp #{previous_release}/config/nginx.conf #{current_path}/config/nginx.conf; then #{sudo} /etc/init.d/nginx reload; fi\""
    end
  end
end

if fetch(:web_server, :nginx) == :nginx
  before "deploy:start",   "capone:nginx:enable_vhost"
  after  "deploy:stop",    "capone:nginx:disable_vhost"
  after  "deploy:restart", "capone:nginx:reload_if_config_file_changed"
end
