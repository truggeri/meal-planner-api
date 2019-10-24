class CreateAccount < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.boolean     :active,       null: false, default: true
      t.string      :name,         null: false
      t.integer     :users_count,  null: false, default: 0
      t.timestamps
    end
  end
end
