class RemoveFkOnRi < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :recipe_ingredients, :recipes
  end
end
