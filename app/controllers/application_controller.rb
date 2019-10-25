require "logger"
require "sinatra/base"
require "sinatra/json"

class ApplicationController < Sinatra::Base
  NO_CONTENT         = 204
  NOT_FOUND          = [404, { "Content-Type" => "application/json" }, {}].freeze
  SINGLE_QUERY_LIMIT = 100

  private

  def logger
    @logger ||= ::Logger.new(STDOUT)
  end
end
