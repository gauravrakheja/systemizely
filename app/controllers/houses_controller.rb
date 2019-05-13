class HousesController < ApplicationController
  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    if @house.save
      flash[:success] = "House created"
    else
      flash[:danger] = "House could not be created"
    end
    redirect_back(fallback_location: root_path)
  end

  def manage
    @houses = current_user.houses.includes(:house_members)
  end

  def show
    @house = House.find(params[:id])
  end

  private

  def house_params
    params.require(:house).permit(:name, :owner_id)
  end
end