namespace :capone do
  namespace :update do
    desc <<-DESC
      Update all.
    DESC
    task :default do
      software
      gems
    end

    desc <<-DESC
      Update system software.
    DESC
    task :software do
      sudo "aptitude update"
      sudo "aptitude safe-upgrade -y"
    end

    desc <<-DESC
      Update installed gems.
    DESC
    task :gems do
      sudo "gem update --no-rdoc --no-ri"
    end
  end
end
