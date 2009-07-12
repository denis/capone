# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{capone}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Denis Barushev"]
  s.date = %q{2009-07-12}
  s.email = %q{barushev@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "lib/capone.rb",
     "recipes/backup.rb",
     "recipes/cron.rb",
     "recipes/deploy.rb",
     "recipes/git.rb",
     "recipes/install.rb",
     "recipes/update.rb",
     "tasks/capone_tasks.rake",
     "templates/Capfile",
     "templates/config/cron.erb",
     "templates/config/deploy.rb",
     "templates/config/mongrel_cluster.yml.erb",
     "templates/config/monitrc",
     "templates/lib/tasks/chores.rake",
     "templates/system/nginx.conf"
  ]
  s.homepage = %q{http://github.com/denis/capone}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Capone is the set of rake tasks and capistrano recipes.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
