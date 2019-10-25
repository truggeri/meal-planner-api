require_relative "config/environment"
require_relative "lib/tasks/docker_database"
require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require "sinatra/activerecord"
    set :database_file, "./database.yml"
  end
end

# @see https://github.com/seattlerb/minitest#running-your-tests
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: :test

desc "Start a console"
task :console do
  binding.pry # rubocop:disable Lint/Debugger
end
