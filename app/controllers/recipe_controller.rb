class RecipesController < ApplicationController
  ENTITY_PATH = "/recipe".freeze
  INDEX_PATH  = "#{ENTITY_PATH}s".freeze

  # index
  get INDEX_PATH do
    NOT_FOUND
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
