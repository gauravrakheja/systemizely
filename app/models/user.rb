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
  has_many :todos, inverse_of: :owner
  has_many :created_wishlist_items,
           class_name: "WishlistItem",
           inverse_of: :creator,
           foreign_key: :creator_id
  has_many :wishlist_items,
           through: :houses

  def house_member_for(house)
    house_members.detect do |house_member|
      house_member.house?(house)
    end
  end
end
