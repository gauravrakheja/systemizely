class CurrentHousesController < ApplicationController
  def set
    house = House.find_by(id: params[:current_house])
    if house.present?
      cookies.permanent[:current_house_id] = house.id
      flash[:success] = "Current House updated"
    else
      flash[:danger] = "House could not be set"
    end
    redirect_back(fallback_location: root_path)
  end
end