class House < ApplicationRecord
  belongs_to :owner,
             class_name: "User",
             inverse_of: :owned_houses
  has_many :house_members,
           dependent: :destroy,
           inverse_of: :house
  has_many :members, through: :house_members
  validates :name, uniqueness: true, presence: true
  after_create :add_owner_as_member
  has_many :todos, inverse_of: :house

  def house_member_for(user)
    house_members.detect do |house_member|
      house_member.member?(user)
    end
  end

  def add_member(user)
    house_members.find_or_create_by(member: user)
  end

  def owner?(user)
    owner_id == user.id
  end

  private

  def add_owner_as_member
    add_member(owner)
  end
end
