class TodoSyncService
  attr_reader :tree_data

  def initialize(tree_data)
    @tree_data = if tree_data.is_a?(String)
                   JSON.parse(tree_data)
                 else
                   tree_data
                 end
    raise ResponseError.new("The tree data was malformed") if tree_data.blank?
  rescue => e
    raise ResponseError.new("The tree data was malformed")
  end

  def run
    parse_tree_data(tree_data)
    HttpSuccessResponse.new("Tree successfully synced")
  end

  private

  def parse_tree_data(nodes, grand_parent = nil)
    nodes.each do |todo_info|
      if todo_info["id"].blank?
        parent = Todo.create(
          creator_id: todo_info["creator_id"],
          house_id: todo_info["house_id"],
          completed: todo_info["completed"],
          expanded: todo_info["expanded"]
        )
      else
        parent = Todo.find_by(id: todo_info["id"])
      end

      if todo_info["name"].present?
        parent.update(title: todo_info["name"])
      end

      parent.update(
        parent: grand_parent,
        expanded: todo_info["expanded"],
        completed: todo_info["completed"]
      )
      next unless parent.present?
      next if todo_info["children"].empty?

      parse_tree_data(todo_info["children"], parent)
    end
  end
end