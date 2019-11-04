class RecipeIngredientsController < ApplicationController
  ENTITY_PATH = "/recipe/:id/ingredient".freeze
  INDEX_PATH  = "#{ENTITY_PATH}s".freeze

  # index
  get INDEX_PATH do
    recipe = load_recipe(params[:id])
    halt NOT_FOUND if recipe.blank?

    json(recipe.recipe_ingredients.map { |ri| IngredientInRecipe.new(recipe_ingredient: ri).to_h })
  end

  private

  def permitted_params
    @permitted_params ||= %i[id description minutes_to_make visible]
  end

  def load_recipe(id)
    Recipe.includes(:recipe_ingredients, :ingredients).select(permitted_params).find_by(id: id)
  end
end
