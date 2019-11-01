class IngredientsController < ApplicationController
  ENTITY_PATH = "/ingredient".freeze
  INDEX_PATH  = "#{ENTITY_PATH}s".freeze

  # index
  get INDEX_PATH do
    ingredients = Ingredient.all
    halt NO_CONTENT if ingredients.count.zero?

    json ingredients.select(permitted_params).limit(SINGLE_QUERY_LIMIT).order(:id)
  end

  get "#{INDEX_PATH}/index" do
    redirect to("/")
  end

  # view
  get "#{ENTITY_PATH}/:id" do
    ingredient = Ingredient.select(permitted_params).find_by(id: params[:id])
    halt NOT_FOUND if ingredient.blank?

    json ingredient
  end

  # create
  post ENTITY_PATH do
    halt BAD_REQUEST if %i[name description fresh].any? { |p| params[p].blank? }

    existing_ingredient = Ingredient.where(name: params[:name])
    halt CONFLICT, "Resource exists" if existing_ingredient.present?

    new_ingredient = Ingredient.create(name: params[:name], description: params[:description], fresh: params[:fresh])
    json new_ingredient.slice(permitted_params)
  end

  # update
  patch "#{ENTITY_PATH}/:id" do
    existing_ingredient = Ingredient.find_by(id: params[:id])
    halt NOT_FOUND unless existing_ingredient.present?

    params_to_update = params.slice(*(permitted_params - [:id]))
    existing_ingredient.update!(params_to_update)
    existing_ingredient.reload
    json existing_ingredient.slice(permitted_params)
  end

  # delete
  delete "#{ENTITY_PATH}/:id" do
    existing_ingredient = Ingredient.find_by(id: params[:id])
    halt NOT_FOUND unless existing_ingredient.present?

    existing_ingredient.delete
    200
  end

  private

  def permitted_params
    @permitted_params ||= %i[id name description fresh]
  end
end
