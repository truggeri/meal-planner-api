require "logger"
require "sinatra"
require "require_all"
require_all "app"

configure :production, :development do
  enable :logging
  use Rack::CommonLogger, ::Logger.new(STDOUT)
end

run ApplicationController
use HealthController
use IngredientsController
use RecipesController
