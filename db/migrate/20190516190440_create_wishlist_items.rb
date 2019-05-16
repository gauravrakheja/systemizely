class CreateWishlistItems < ActiveRecord::Migration[6.0]
  def change
    create_table :wishlist_items do |t|
      t.references :wishlist, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :title
      t.string :link
      t.decimal :cost
      t.date :buy_by

      t.timestamps
    end
  end
end
