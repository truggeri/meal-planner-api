require "test_helper"

class IngredientRequestTest < Minitest::Test
  include Rack::Test::Methods

  PERMITTED_PARAMS = %i[id name description fresh].freeze

  def app
    IngredientsController
  end

  def test_index_with_no_content
    get "/ingredients"
    assert last_response.status == 204
  end

  def test_index_with_one_ingredients
    ingredient = create(:ingredient)

    get "/ingredients"
    assert last_response.status == 200
    assert_equal [ingredient.slice(PERMITTED_PARAMS)].to_json, last_response.body
  end

  def test_index_with_many_ingredients
    ingredient1 = create(:ingredient)
    ingredient2 = create(:ingredient)

    get "/ingredients"
    assert last_response.status == 200
    assert_equal [ingredient1.slice(PERMITTED_PARAMS),
                  ingredient2.slice(PERMITTED_PARAMS)].to_json, last_response.body
  end

  def test_view_with_no_content
    get "/ingredient/1"
    assert last_response.status == 404
  end

  def test_view_with_ingredient
    ingredient = create(:ingredient)

    get "/ingredient/#{ingredient.id}"
    assert last_response.status == 200
    assert_equal ingredient.slice(PERMITTED_PARAMS).to_json, last_response.body
  end
end
