require "logger"
require "sinatra/base"

class ApplicationController < Sinatra::Base
  private

  def logger
    @logger ||= ::Logger.new(STDOUT)
  end
end
