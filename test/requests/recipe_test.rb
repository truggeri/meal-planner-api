require "test_helper"

class RecipeRequestTest < Minitest::Test
  include Rack::Test::Methods

  PERMITTED_PARAMS = %i[id description minutes_to_make visible].freeze

  def app
    RecipesController
  end

  def test_index_with_no_content
    get "/recipes"
    assert last_response.status == 204
  end

  def test_index_with_one_recipe
    recipe = create(:recipe, :with_ingredients)

    get "/recipes"
    assert last_response.status == 200
    ingredient_details = recipe.recipe_ingredients.first.slice(%i[amount measure precise_amount])
    ingredients_hash   = { "ingredients" => { recipe.ingredients.first.name => ingredient_details } }
    expected_body      = [recipe.slice(PERMITTED_PARAMS).merge(ingredients_hash)]
    assert_equal expected_body.to_json, last_response.body
  end
end
