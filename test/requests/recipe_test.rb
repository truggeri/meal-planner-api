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
    assert_equal recipe.slice(PERMITTED_PARAMS).to_json, last_response.body
  end

  def test_create_with_missing_params
    post "/recipe", description: "foo", visible: true
    assert last_response.status == 400
  end

  def test_create_with_valid_params
    recipe = build(:recipe)

    post "/recipe", description: recipe.description, minutes_to_make: recipe.minutes_to_make, visible: recipe.visible
    assert last_response.status == 200
    response = JSON.parse(last_response.body)
    (PERMITTED_PARAMS - [:id]).each do |p|
      assert_equal recipe.send(p), response[p.to_s]
    end
  end

  def test_patch_with_bad_id
    patch "/recipe/1"
    assert last_response.status == 404
  end

  def test_patch_response_body
    recipe = create(:recipe, :with_ingredients)

    patch "/recipe/#{recipe.id}", description: "foo", foo: "bar"
    assert last_response.status == 200
    response = JSON.parse(last_response.body)
    assert_equal recipe.id, response["id"]
  end

  def test_patch_modifies_db
    recipe = create(:recipe, :with_ingredients)

    patch "/recipe/#{recipe.id}", description: "foo", foo: "bar"
    assert last_response.status == 200
    recipe.reload
    assert_equal recipe.description, "foo"
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
end
