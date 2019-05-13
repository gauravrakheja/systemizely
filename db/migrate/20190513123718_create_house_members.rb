class CreateHouseMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :house_members do |t|
      t.references :house, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
