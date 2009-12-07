require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "capone"
    gem.summary = "Capone is the set of rake tasks and capistrano recipes."
    gem.email = "barushev@gmail.com"
    gem.homepage = "http://github.com/denis/capone"
    gem.authors = ["Denis Barushev"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.files = %w(LICENSE README.md) + Dir.glob("{lib,recipes}/**/*")
    gem.add_dependency "capistrano", ">= 2.5.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

task :default => :check_dependencies
