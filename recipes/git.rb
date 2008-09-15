namespace :capone do
  namespace :git do
    desc <<-DESC
      Creates a remote repository and adds it as origin to the local repository.
    DESC
    task :remote do
      run "mkdir ~/git/#{application}.git && cd ~/git/#{application}.git && git --bare init"

      cmd = "git remote add origin #{repository} && git push origin master"
      puts cmd
      `#{cmd}`
    end
  end
end
