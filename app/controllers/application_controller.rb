class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
  rescue_from ResponseError, with: :set_flash_and_redirect_back

  private

  def check_current_house
    unless current_house.present?
      raise ResponseError("You need to select a current house")
    end
  end

  def set_flash_and_redirect_back(exception)
    if request.content_type == "application/json"
      render json: {}, status: :unprocessable_entity
    else
      flash[:danger] = exception.message
      redirect_back(fallback_location: root_path)
    end
  end
end
