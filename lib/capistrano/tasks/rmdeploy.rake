#require 'capistrano/rmdeploy'
###task :redmine => "redmine:default"

namespace :redmine do
  desc <<-DESC
    The task that enables us to update status in the redmine
  DESC
  task :default do
    on roles(:db) do
      puts "Hello Default-Task!"
      from = source.next_revision(previous_revision)
      git_log = capture "cd #{current_release}; git --no-pager log #{from}..HEAD"
      tasks = Cap::Rm::Deploy::Issue.get_list(git_log)
      tasks.each do |task_id|
        issue = ::Cap::Rm::Deploy::Issue.find(task_id) rescue (puts "Unable to find #{task_id}")
        next if issue.nil? 
        issue.process!
      end
    end
  end
end

after "deploy:restart", "redmine:default"