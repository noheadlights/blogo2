require 'capistrano/ext/multistage'

set :application, "blogo"
set :repository,  "git@github.com:noheadlights/blogo2.git"

#set :deploy_via, :copy


set :scm, :git
set :scm_passphrase, ""

set :user, "deployer"

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :use_sudo, "false"