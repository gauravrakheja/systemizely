class HouseMembersController < ApplicationController
  def create
    user = User.find_by(email: house_member_params[:email])
    if user.present?
      @house_member = HouseMember.new(
        member: user,
        house_id: house_member_params[:house_id]
      )
      if @house_member.save
        flash[:success] = "Member Added to the house"
      else
        flash[:danger] = "Member could not be Added to the house"
      end
    else
      flash[:danger] = "The email is not registered on the platform"
    end
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