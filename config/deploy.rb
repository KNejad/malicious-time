set :deploy_to, '/var/www/time.keeyan.xyz'

set :ssh_options, {:forward_agent => true }

set :repo_url, 'git@github.com/knejad/malicious-time.git'

set :stage, fetch(:stage)
set :rails_env, fetch(:stage)

current_branch = `git branch`.match(/\* (\S+)\s/m)[1]

set :branch, current_branch
set :pty, true
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle}

set :keep_releases, 1

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:stage).to_s
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, true

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "/usr/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails puma pumactl}
set :rbenv_roles, :all

namespace :deploy do
  after :finishing, :compile_assets
  after :finishing, :cleanup
end
