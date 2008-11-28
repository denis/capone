# Original version of this file was excerpted from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
namespace :capone do
  namespace :cron do
    desc <<-DESC
      Starts cron (on the cron machine only).
    DESC
    task :start, :roles => :app, :only => {:cron => true} do
      cron_tab = "#{shared_path}/crontab.txt"

      require 'erb'
      template = File.read("config/cron.erb")
      file = ERB.new(template).result(binding)
      put file, cron_tab, :mode => 0644

      # merge with the current crontab
      # fails with an empty crontab, which is acceptable
      run "crontab -l >> #{cron_tab}" rescue nil

      # install the new crontab
      run "crontab #{cron_tab}"
    end

    desc <<-DESC
      Stops cron (on the cron machine only).
    DESC
    task :stop, :roles => :app, :only => {:cron => true} do
      cron_tmp = "#{shared_path}/~crontab.txt"
      cron_tab = "#{shared_path}/crontab.txt"

      begin
        # dump the current cron entries
        run "crontab -l > #{cron_tmp}"

        # remove any lines that contain the application name
        run "awk '{if ($0 !~ /#{application}/) print $0}' " +
            "#{cron_tmp} > #{cron_tab}"

        # replace the cron entries
        run "crontab #{cron_tab}"
        rescue
        # fails with an empty crontab, which is acceptable
      end

      # clean up
      run "rm -rf #{cron_tmp}"
    end
  end
end
