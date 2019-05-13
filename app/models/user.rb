class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :owned_houses,
           class_name: "House",
           inverse_of: :owner,
           foreign_key: :owner_id
  has_many :house_members,
           dependent: :destroy,
           inverse_of: :member,
           foreign_key: :member_id
  has_many :houses, through: :house_members

  def house_member_for(house)
    house_members.detect do |house_member|
      house_member.house?(house)
    end
  end
end
