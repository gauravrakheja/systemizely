class HouseMembersController < ApplicationController
  def create
    response = AddMemberToHouseService.new(house_member_params[:email], house_member_params[:house_id]).run
    flash[response.flash] = response.message
    redirect_back(fallback_location: manage_houses_path)
  end

  def destroy
    @house_member = HouseMember.find(params[:id])
    if @house_member.destroy
      flash[:success] = "Member Kicked"
    else
      flash[:danger] = "Member could not be Kicked"
    end
    redirect_back(fallback_location: manage_houses_path)
  end

  private

  def house_member_params
    params.permit!
  end
end