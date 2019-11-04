require "test_helper"

class RecipeIngredientRequestTest < Minitest::Test
  include Rack::Test::Methods

  PERMITTED_PARAMS = %i[id description minutes_to_make visible].freeze

  def app
    RecipeIngredientsController
  end

  def test_index_with_bad_id
    get "/recipes/123/ingredients"
    assert last_response.status == 404
  end

  def test_index_with_no_content
    recipe = create(:recipe)

    get "/recipe/#{recipe.id}/ingredients"
    assert last_response.status == 200
    assert_equal "[]", last_response.body
  end

  def test_index_with_one_recipe
    recipe = create(:recipe, :with_ingredients)

    get "/recipe/#{recipe.id}/ingredients"
    assert last_response.status == 200
    expected = IngredientInRecipe.new(recipe_ingredient: recipe.recipe_ingredients.first).to_h
    assert_equal [expected].to_json, last_response.body
  end
end
