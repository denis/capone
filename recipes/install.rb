namespace :capone do
  namespace :install do
    desc <<-DESC
      Install all software for all servers.
    DESC
    task :default do
        update::software
        app
        web
        db
    end

    desc <<-DESC
      Install all software for app-server.
    DESC
    task :app, :roles => :app do
      subversion
      ruby
      rubygems
      gems
      mongrel
    end

    desc <<-DESC
      Install all software for web-server.
    DESC
    task :web, :roles => :web do
      nginx
    end

    desc <<-DESC
      Install all software for db server.
    DESC
    task :db, :roles => :db do
      mysql
    end

    desc <<-DESC
      Install Subversion.
    DESC
    task :subversion, :roles => :app do
      sudo "aptitude install -y subversion"
    end

    desc <<-DESC
      Install Ruby.
    DESC
    task :ruby, :roles => :app do
      sudo "aptitude install ruby ruby1.8-dev irb irb1.8 rdoc rdoc1.8 libopenssl-ruby1.8 libreadline-ruby1.8"
    end

    desc <<-DESC
      Install RubyGems.
    DESC
    task :rubygems, :roles => :app do
      sudo "aptitude install libgems-ruby1.8 rubygems"
      sudo "gem update --system --no-rdoc --no-ri"
      sudo "ln -fs /usr/bin/gem1.8 /usr/bin/gem"
    end

    desc <<-DESC
      Install common gems.
    DESC
    task :gems, :roles => :app do
      sudo "aptitude install -y build-essential libmysqlclient15-dev"
      sudo "gem install rake mysql --no-rdoc --no-ri"
    end

    desc <<-DESC
      Install Mongrel.
    DESC
    task :mongrel, :roles => :app do
      sudo "gem install mongrel mongrel_cluster --no-rdoc --no-ri"

      sudo "ln -sf /usr/lib/ruby/gems/1.8/gems/mongrel_cluster-1.0.5/resources/mongrel_cluster /etc/init.d/mongrel_cluster"
      sudo "chmod +x /etc/init.d/mongrel_cluster"
      sudo "/usr/sbin/update-rc.d mongrel_cluster defaults"
      sudo "mkdir /etc/mongrel_cluster"

      sudo "mkdir -p -m 750 /var/www/apps"
      sudo "chown deploy:deploy /var/www/apps"
    end

    desc <<-DESC
      Install nginx.
    DESC
    task :nginx, :roles => :web do
      sudo "aptitude install nginx"
    end

    desc <<-DESC
      Install MySQL.
    DESC
    task :mysql, :roles => :db do
      sudo "aptitude install -y mysql-server"
    end
  end
end
