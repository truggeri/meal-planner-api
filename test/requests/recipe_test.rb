require "test_helper"

class RecipeRequestTest < Minitest::Test
  include Rack::Test::Methods

  PERMITTED_PARAMS = %i[id description minutes_to_make visible].freeze

  def app
    RecipesController
  end
end
