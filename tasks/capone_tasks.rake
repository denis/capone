desc "Init Capone"
task :capone do
  puts "Generating configs..."

  files = ["Capfile", "config/deploy.rb"]

  for file in files do
    if File.exists? "#{RAILS_ROOT}/#{file}"
      puts "#{RAILS_ROOT}/#{file} already exists"
    else
      File.copy "#{RAILS_ROOT}/vendor/plugins/capone/templates/#{file}", "#{RAILS_ROOT}/#{file}"
    end
  end
end

namespace :capone do
end
