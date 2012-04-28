#############################################################
#   Application
#############################################################
set :user, "bonne"
set :application, "twilio"
set :deploy_to, "/opt/nginx/html/public/"
#set :deploy_to, "/home/#{user}/apps/#{application}"
#############################################################
#   SVN
#############################################################
set :scm, :subversion
set :svn_user, ENV['svn_user'] || "jobonne"
set :svn_password, ENV['svn_password'] || "bL1QwJNYHYWWGfA"
set :repository,
 Proc.new { "--username #{svn_user} " +
            "--password #{svn_password} " +
            "--no-auth-cache " +
            "http://svn.9-1-1labs.com/svn/tama" }

#############################################################
#   Settings
#############################################################
 default_run_options[:pty] = true
 ssh_options[:forward_agent] = true
 set :use_sudo, true
 set :rails_env, "staging" 
 set :sudo_prompt, ""
#############################################################
#   Servers
#############################################################
  
  #set :domain, "--------------------------"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "204.144.140.197:9522"                          # Your HTTP server, Apache/etc
role :app, "204.144.140.197:9522"                          # This may be the same as your `Web` server
role :db,  "204.144.140.197:9522", :primary => true # This is where Rails migrations will run
role :db,  "204.144.140.197:9522"
after "deploy", "deploy:cleanup" # keep only the last 5 releases
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end