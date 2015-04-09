# require 'rmdeploy'
require_relative '../../capistrano-rmdeploy'

# require 'lib/capistrano/rmdeploy'
###task :redmine => "redmine:default"

# namespace :redmine do
#   desc <<-DESC
#     The task that enables us to update status in the redmine
#   DESC
#   task :default do
#     on roles(:db) do
#       from = source.next_revision(previous_revision)
#       git_log = capture "cd #{current_release}; git --no-pager log #{from}..HEAD"
#       tasks = Capistrano::Rmdeploy::Issue.get_list(git_log)
#       tasks.each do |task_id|
#         issue = Capistrano::Rmdeploy::Issue.find(task_id) rescue (puts "Unable to find #{task_id}")
#         next if issue.nil? 
#         issue.process!
#       end
#     end
#   end
# end
# Capistrano::Rmdeploy::Issue

namespace :redmine do
  desc <<-DESC
    The task that enables us to update status in the redmine
  DESC
  task :default do
    on roles(:db) do
      git_log = "cd #{release_path}; git --no-pager log --reverse --ancestry-path #{fetch(:previous_revision)}..HEAD"
      tasks = Capistrano::Rmdeploy::Issue.list(git_log)
      tasks.each do |task_id|
        issue = Capistrano::Rmdeploy::Issue.find(task_id) rescue (puts "Unable to find #{task_id}")
        next if issue.nil? 
        issue.process!
      end
    end
  end
end

after "deploy:finished", "redmine:default"
