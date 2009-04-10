unless Capistrano::Configuration.respond_to?(:instance)
  abort "Capone requires Capistrano 2"
end

Capistrano::Configuration.instance.load do
  Dir["#{File.dirname(__FILE__)}/../recipes/*.rb"].each do |recipe|
    load(recipe)
  end
end
