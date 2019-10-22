require "logger"
require "sinatra"
require "require_all"
require_all "app"

configure :production, :development do
  enable :logging
  use Rack::CommonLogger, ::Logger.new(STDOUT)
end

map("/") { run HealthController }
