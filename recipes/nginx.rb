namespace :capone do
  namespace :nginx do
    desc <<-DESC
      Enable virtual host.
    DESC
    task :enable_vhost do
      sudo "ln -fs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
      sudo "/etc/init.d/nginx reload"
    end

    desc <<-DESC
      Disable virtual host.
    DESC
    task :disable_vhost do
      sudo "rm /etc/nginx/sites-enabled/#{application}"
      sudo "/etc/init.d/nginx reload"
    end

    desc <<-DESC
      Reload nginx configuration if config file was changed.
    DESC
    task :reload_if_config_file_changed do
      run "bash -c \"if ! cmp #{previous_release}/config/nginx.conf #{current_path}/config/nginx.conf; then #{sudo} /etc/init.d/nginx reload; fi\""
    end
  end
end
