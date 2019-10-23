class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.text    :description,     null: false, limit: 500
      t.integer :minutes_to_make, size: 2
      t.string  :name,            null: false, limit: 50
      t.boolean :visible,         null: false, default: true

      t.timestamps
    end
  end
end
