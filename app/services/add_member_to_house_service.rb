class AddMemberToHouseService
  attr_reader :email, :user, :house_id, :house

  def initialize(email, house_id)
    @email    = email
    @house_id = house_id
    set_user
    set_house
  end

  def run
    house_member = HouseMember.new(
      member: user,
      house: house
    )
    if house_member.save
      HttpSuccessResponse.new("Member Added to the house")
    else
      HttpFailedResponse.new("Member could not be added to the house")
    end
  end

  private
  attr_writer :user, :house

  def set_user
    self.user = User.find_by(email: email)
    unless user.present?
      raise ResponseError.new("The email is not registered on the platform")
    end
  end

  def set_house
    self.house = House.find(house_id)
  rescue ActiveRecord::RecordNotFound
    raise ResponseError.new("The email is not registered on the platform")
  end
end