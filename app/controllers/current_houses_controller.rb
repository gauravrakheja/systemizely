class CurrentHousesController < ApplicationController
  def set
    response = CurrentHouseService.new(house_id: params[:current_house], session: session).run
    flash[response.flash] = response.message
    redirect_back(fallback_location: root_path)
  end
end