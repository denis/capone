namespace :capone do
  namespace :install do
    desc <<-DESC
      Install all.
    DESC
    task :default do
        ruby
        rubygems
    end

    desc <<-DESC
      Install MySQL.
    DESC
    task :mysql, :roles => :db do
      sudo "aptitude install mysql"
    end

    desc <<-DESC
      Install Ruby.
    DESC
    task :ruby, :roles => :app do
      sudo "aptitude install ruby"
    end

    desc <<-DESC
      Install software.
    DESC
    task :software do
      sudo "aptitude install subversion"
    end

    desc <<-DESC
      Install rubygems.
    DESC
    task :rubygems, :roles => :app do
      run "cd /tmp"
      run "wget http://rubyforge.rubyuser.de/rubygems/rubygems-1.1.0.tgz"
      run "tar zxvf rubygems-1.1.0.tgz"
      run "cd rubygems-1.1.0"

      sudo "ruby setup.rb"
      sudo "gem update --system"

      run "rm -Rf /tmp/rubygems-1.1.0"
    end

    desc <<-DESC
      Install gems.
    DESC
    task :gems, :roles => :app do
      sudo "rake gems:install"
    end
  end
end
