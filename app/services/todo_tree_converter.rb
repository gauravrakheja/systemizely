class TodoTreeConverter
  attr_reader :todos

  def initialize(todos)
    @todos = todos
  end

  def run
    todos.hash_tree.map do |todo, children|
      {
        id: todo.id,
        name: todo.title,
        expanded: todo.expanded,
        completed: todo.completed,
        house_id: todo.house_id,
        creator_id: todo.creator_id,
        children: recursively_jsonify(children)
      }
    end.to_json
  end

  private

  def recursively_jsonify(children)
    children.map do |todo, grand_children|
      {
        id: todo.id,
        name: todo.title,
        expanded: todo.expanded,
        completed: todo.completed,
        house_id: todo.house_id,
        creator_id: todo.creator_id,
        children: grand_children.empty? ? [] : recursively_jsonify(grand_children)
      }
    end
  end
end