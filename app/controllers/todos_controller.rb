class TodosController < ApplicationController
  include UsersHelper
  skip_before_action :verify_authenticity_token, only: %i[sync]
  skip_before_action :authenticate_user!, only: %i[sync]

  def sync
    response = TodoSyncService.new(sync_params[:tree_data]).run
    if request.content_type == "application/json"
      render json: { treeData: TodoTreeConverter.new(current_house&.todos).run }, status: :ok
    else
      flash[response.flash] = response.message
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def sync_params
    params.permit!
  end
end