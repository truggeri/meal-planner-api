require "logger"
require "sinatra/base"
require "sinatra/json"

class ApplicationController < Sinatra::Base
  NO_CONTENT         = 204
  BAD_REQUEST        = 400
  NOT_FOUND          = [404, { "Content-Type" => "application/json" }, {}].freeze
  CONFLICT           = 409
  SINGLE_QUERY_LIMIT = 100

  private

  def logger
    @logger ||= ::Logger.new(STDOUT)
  end
end
