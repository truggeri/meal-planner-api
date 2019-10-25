class IngredientsController < ApplicationController
  get "/" do
    ingredients = Ingredient.all
    halt NO_CONTENT if ingredients.count.zero?

    json ingredients.select(permitted_params).limit(SINGLE_QUERY_LIMIT).order(:id)
  end

  get "/index" do
    redirect to("/")
  end

  get "/:id" do
    ingredient = Ingredient.select(permitted_params).find_by(id: params[:id])
    halt NOT_FOUND if ingredient.blank?

    json ingredient
  end

  private

  def permitted_params
    %i[id name description fresh]
  end
end
