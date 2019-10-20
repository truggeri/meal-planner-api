require "logger"
require "sinatra/base"

class ApplicationController < Sinatra::Base
  Logger.class_eval { alias :write :"<<" }
  logger = ::Logger.new(STDOUT)

  configure do
    use Rack::CommonLogger, logger
  end
end