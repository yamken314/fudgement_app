# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "Judgement_app"
set :repo_url, "https://github.com/yamken314/Judgement_app"

# deployするブランチ。デフォルトはmasterなのでなくても可。
set :branch, 'master'

# deploy先のディレクトリ。 
set :deploy_to, '/var/www/rails/Judgement_app'

# シンボリックリンクをはるファイル。(※後述)
set :linked_files, fetch(:linked_files, []).push('config/settings.yml')

# シンボリックリンクをはるフォルダ。(※後述)
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# 保持するバージョンの個数(※後述)
set :keep_releases, 5

# rubyのバージョン
set :rbenv_ruby, '2.6.5'

#出力するログのレベル。
set :log_level, :debug

namespace :deploy do
  task :init_permission do
    on release_roles :all do
      execute :sudo, :chown, '-R', "#{fetch(:user)}:#{fetch(:group)}", deploy_to
    end
  end

  task :reset_permission do
    on release_roles :all do
      execute :sudo, :chown, '-R', "nginx:nginx", deploy_to
    end
  end

  before :starting, :init_permission
  after :finished, :reset_permission
  
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end