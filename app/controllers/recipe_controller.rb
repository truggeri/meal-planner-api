class RecipesController < ApplicationController
  ENTITY_PATH = "/recipe".freeze
  INDEX_PATH  = "#{ENTITY_PATH}s".freeze

  # index
  get INDEX_PATH do
    halt NO_CONTENT if Recipe.where(visible: true).count.zero?

    recipes = Recipe.where(visible: true).select(permitted_params).limit(SINGLE_QUERY_LIMIT).order(:id)
    json recipes
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
    existing_recipe = Recipe.find_by(id: params[:id])
    halt NOT_FOUND unless existing_recipe.present?

    params_to_update = params.slice(*(permitted_params - [:id]))
    existing_recipe.update!(params_to_update)
    existing_recipe.reload
    json existing_recipe.slice(permitted_params)
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
