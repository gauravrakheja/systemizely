class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
  rescue_from ResponseError, with: :set_flash_and_redirect_back

  private

  def set_flash_and_redirect_back(exception)
    flash[:danger] = exception.message
    redirect_back(fallback_location: root_path)
  end
end
