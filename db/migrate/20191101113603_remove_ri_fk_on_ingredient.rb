class RemoveRiFkOnIngredient < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :recipe_ingredients, :ingredients
  end
end
