class RecipesController < ApplicationController
  ENTITY_PATH = "/recipe".freeze
  INDEX_PATH  = "#{ENTITY_PATH}s".freeze

  # index
  get INDEX_PATH do
    halt NO_CONTENT if Recipe.where(visible: true).count.zero?

    recipes = Recipe.includes(:recipe_ingredients, :ingredients)
                    .where(visible: true)
                    .limit(SINGLE_QUERY_LIMIT)
                    .order(:id)
    output = []
    recipes.each { |r| output << format_with_ingredients(r) }
    json output
  end

  # view
  get "#{ENTITY_PATH}/:id" do
    recipe = Recipe.includes(:recipe_ingredients, :ingredients).select(permitted_params).find_by(id: params[:id])
    halt NOT_FOUND if recipe.blank?

    json format_with_ingredients(recipe)
  end

  # create
  post ENTITY_PATH do
    NOT_FOUND
  end

  # update
  patch "#{ENTITY_PATH}/:id" do
    NOT_FOUND
  end

  # delete
  delete "#{ENTITY_PATH}/:id" do
    existing_recipe = Recipe.find_by(id: params[:id])
    halt NOT_FOUND unless existing_recipe.present?

    existing_recipe.delete
    200
  end

  private

  def permitted_params
    @permitted_params ||= %i[id description minutes_to_make visible]
  end

  def format_with_ingredients(recipe)
    ingredients_hash = recipe.recipe_ingredients.each_with_object({}) do |ri, hash|
      hash[ri.ingredient.name] = ri.slice(%i[amount measure precise_amount])
    end
    recipe.slice(permitted_params).merge(ingredients: ingredients_hash)
  end
end
