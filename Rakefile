require_relative "config/environment"
require_relative "lib/tasks/docker_database"
require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require "sinatra/activerecord"
    set :database_file, "./database.yml"
  end
end