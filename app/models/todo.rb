class Todo < ApplicationRecord
  belongs_to :house, inverse_of: :todos
  belongs_to :creator,
             foreign_key: :creator_id,
             class_name: "User",
             inverse_of: :todos

  validates :title,
            uniqueness: true

  acts_as_tree(name_column: :title)
end
