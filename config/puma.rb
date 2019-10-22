require_relative "environment"

workers 1
threads_count = 5
threads threads_count, threads_count

rackup      DefaultRackup
port        ENV["PORT"] || 4000
environment ENV["RACK_ENV"] || ENV["SINATRA_ENV"]
