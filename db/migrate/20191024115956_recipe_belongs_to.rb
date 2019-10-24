class RecipeBelongsTo < ActiveRecord::Migration[6.0]
  def change
    add_column      :recipes, :account_id, :bigint
    add_foreign_key :recipes, :accounts
    add_index       :recipes, :account_id

    add_column      :recipe_ingredients, :account_id, :bigint
    add_foreign_key :recipe_ingredients, :accounts
    add_index       :recipe_ingredients, :account_id
  end
end
