class Todo < ApplicationRecord
  belongs_to :house, inverse_of: :todos
  belongs_to :creator,
             foreign_key: :creator_id,
             class_name: "User",
             inverse_of: :todos

  validates :title,
            uniqueness: true

  acts_as_tree(name_column: :title)

  class << self
    def to_json
      hash_tree.map do |todo, children|
        {
          id: todo.id,
          title: todo.title,
          children: recursively_jsonify(children)
        }
      end.to_json
    end

    private

    def recursively_jsonify(children)
      children.map do |todo, grand_children|
        {
          id: todo.id,
          title: todo.title,
          children: grand_children.empty? ? [] : recursively_jsonify(grand_children)
        }
      end
    end
  end
end
