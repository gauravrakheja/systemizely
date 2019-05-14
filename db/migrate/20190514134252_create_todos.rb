class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :completed, default: false
      t.references :house
      t.references :creator, foreign_key: { to_table: :users }

      t.references :parent, foreign_key: { to_table: :todos }

      t.timestamps
    end
  end
end
