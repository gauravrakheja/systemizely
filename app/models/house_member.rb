class HouseMember < ApplicationRecord
  belongs_to :house, inverse_of: :house_members
  belongs_to :member, class_name: "User", inverse_of: :house_members

  validates :member_id, uniqueness: { scope: :house_id, message: "Member can only be added once" }

  def member?(user)
    member_id == user.id
  end

  def house?(other_house)
    other_house.id == house_id
  end
end
