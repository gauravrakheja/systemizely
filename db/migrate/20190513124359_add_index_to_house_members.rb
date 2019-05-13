class AddIndexToHouseMembers < ActiveRecord::Migration[6.0]
  def change
    add_index :house_members, [:member_id, :house_id]
  end
end
