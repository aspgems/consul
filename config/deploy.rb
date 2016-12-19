# config valid only for current version of Capistrano
lock '3.5.0'

set :client, 'aytochiloeches'
set :application, 'chiloechesconsul'

set :repo_url, 'git@github.com:aspgems/consul.git'

set :user, fetch(:application)
set :deploy_to, -> { "/home/#{fetch(:user)}/app" }
set :keep_releases, 5

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs,  fetch(:linked_dirs,  []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Files that won't be copied from script/deploy/{branch}/ into the root directory
set :exclude_deployment_files, []

set :ssh_options, -> {
  {
      user: fetch(:user),
      forward_agent: true,
      compression: 'none',
  }
}

set :rails_env, 'production'
set :scm, :git
set :log_level, :info

set :delayed_job_workers, 2
set :delayed_job_roles, :background

set :whenever_roles, -> { :app }

# capistrano-db-tasks related
# if you want to remove the dump file after loading
set :db_local_clean, true
# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server
set :assets_dir, %w(public/assets)
# if you want to work on a specific local environment (default = ENV['RAILS_ENV'] || 'development')
set :locals_rails_env, "development"

# # Hipchat notification
# set :hipchat_token, '77336b5d1c0704efe157e97e8cb04c'
# set :hipchat_room_name, '1000843'
# set :hipchat_announce, true # notify users?
# set :hipchat_env, -> { fetch(:app_env) }

namespace :deploy do
  after :published, 'delayed_job:restart'

  after :finishing, 'deploy:cleanup'
end
