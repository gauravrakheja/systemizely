class TodosController < ApplicationController
  include UsersHelper
  skip_before_action :verify_authenticity_token, only: %i[sync destroy]
  skip_before_action :authenticate_user!, only: %i[sync destroy]
  before_action :check_current_house, only: %i[index]

  def sync
    response = TodoSyncService.new(sync_params[:tree_data]).run
    if request.content_type == "application/json"
      render json: { treeData: TodoTreeConverter.new(current_house&.todos).run }, status: :ok
    else
      flash[response.flash] = response.message
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    render json: {}, status: :ok
  end

  def index
    @tree_data = TodoTreeConverter.new(current_house&.todos).run
  end

  private

  def sync_params
    params.permit!
  end
end