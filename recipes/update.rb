namespace :capone do
  namespace :update do
    desc <<-DESC
      Update system software.
    DESC
    task :system do
      sudo "aptitude update"
      sudo "aptitude upgrade"
    end

    desc <<-DESC
      Update installed gems.
    DESC
    task :gems do
      sudo "gem update"
    end
  end
end
