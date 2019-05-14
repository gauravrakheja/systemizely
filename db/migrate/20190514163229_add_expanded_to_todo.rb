class AddExpandedToTodo < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :expanded, :boolean, default: false
  end
end
