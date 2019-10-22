class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :name,        null: false
      t.string :description, null: false
      t.boolean :fresh,      null: false, default: false

      t.timestamps
    end
  end
end
