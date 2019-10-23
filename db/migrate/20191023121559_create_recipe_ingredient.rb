class CreateRecipeIngredient < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_ingredients do |t|
      t.references  :recipe,          index: true, foreign_key: true
      t.references  :ingredient,      index: true, foreign_key: true
      t.integer     :amount,          null: false, size: 2
      t.integer     :measure,         null: false
      t.boolean     :precise_amount,  null: false, default: false
      t.timestamps
    end

    add_index :recipe_ingredients, %i[recipe_id ingredient_id], unique: true
  end
end
