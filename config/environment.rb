ENV["SINATRA_ENV"] ||= "development"

require "bundler/setup"
Bundler.require(:default, ENV["SINATRA_ENV"])

require "./app/controllers/application_controller"
require_all "app"

workers 1
threads_count = 5
threads threads_count, threads_count

rackup      DefaultRackup
port        ENV["PORT"] || 4000
environment ENV["RACK_ENV"] || ENV["SINATRA_ENV"]