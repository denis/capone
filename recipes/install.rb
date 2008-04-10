namespace :capone do
  namespace :install do
    desc <<-DESC
      Install MySQL
    DESC
    task :mysql do
      sudo "aptitude install mysql"
    end

    desc <<-DESC
      Install rubygems
    DESC
    task :rubygems do
      run "cd /tmp"
      run "wget http://rubyforge.rubyuser.de/rubygems/rubygems-1.1.0.tgz"
      run "tar zxvf rubygems-1.1.0.tgz"
      run "cd rubygems-1.1.0"

      sudo "ruby setup.rb"
      sudo "gem update --system"

      run "rm -Rf /tmp/rubygems-1.1.0"
    end

    desc <<-DESC
      Install gems
    DESC
    task :gems do
      sudo "rake gems:install"
    end
  end
end
