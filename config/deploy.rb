require "rvm/capistrano"
require 'bundler/capistrano'

set :application, "blogo"
set :repository,  "git@github.com:noheadlights/blogo2.git"

set :scm, :git
set :scm_passphrase, ""

set :user, "deployer"

server "spaced.homeip.net", :app, :web, :db, :primary => true
set :deploy_to, "/home/deployer/blogo"

set :use_sudo, "false"

after "deploy:update_code","deploy:config_symlink"
namespace :deploy do

  task :config_symlink do
    run "cp /home/deployer/deploy/database.yml #{release_path}/config/database.yml"
  end
end