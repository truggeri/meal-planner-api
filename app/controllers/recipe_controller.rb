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
    recipes.each do |r|
      ingredients_hash = r.recipe_ingredients.each_with_object({}) do |ri, hash|
        hash[ri.ingredient.name] = ri.slice(%i[amount measure precise_amount])
      end
      output << r.slice(permitted_params).merge(ingredients: ingredients_hash)
    end
    json output
  end

  # view
  get "#{ENTITY_PATH}/:id" do
    NOT_FOUND
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
    NOT_FOUND
  end

  private

  def permitted_params
    @permitted_params ||= %i[id description minutes_to_make visible]
  end
end
