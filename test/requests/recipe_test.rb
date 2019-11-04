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
    recipe = create(:recipe, :with_ingredients, visible: true)

    get "/recipes"
    assert last_response.status == 200
    assert_equal [recipe.slice(PERMITTED_PARAMS)].to_json, last_response.body
  end

  def test_view_with_no_content
    get "/recipe/1"
    assert last_response.status == 404
  end

  def test_view_with_ingredient
    recipe = create(:recipe, :with_ingredients)

    get "/recipe/#{recipe.id}"
    assert last_response.status == 200
    assert_equal format_ingredients(recipe).to_json, last_response.body
  end

  def test_delete_with_bad_id
    delete "/recipe/1"
    assert last_response.status == 404
  end

  def test_delete_with_good_id
    recipe = create(:recipe)

    pre_count = Recipe.all.count
    delete "/recipe/#{recipe.id}"
    assert last_response.status == 200
    assert_equal pre_count - 1, Recipe.all.count
  end

  private

  def format_ingredients(recipe)
    ingredient_details = recipe.recipe_ingredients.first.slice(%i[amount measure precise_amount])
    ingredients_hash   = { "ingredients" => { recipe.ingredients.first.name => ingredient_details } }
    recipe.slice(PERMITTED_PARAMS).merge(ingredients_hash)
  end
end
