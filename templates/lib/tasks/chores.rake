# Original version of this file was excerpted from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
namespace :chores do
  desc "Cron run this task once a hour"
  task :hourly => :environment do
    chore("Hourly") do
      # Your Code Here
    end
  end

  desc "Cron run this task once a day"
  task :daily => :environment do
    chore("Daily") do
      # Your Code Here
    end
  end

  desc "Cron run this task once a week"
  task :weekly => :environment do
    chore("Weekly") do
      # Your Code Here
    end
  end

  def chore(name)
    puts "#{name} Task Invoked: #{Time.now}"
    yield
    puts "#{name} Task Finished: #{Time.now}"
  end
end
