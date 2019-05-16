class WishlistItem < ApplicationRecord
  belongs_to :wishlist
  belongs_to :creator,
             class_name: "User",
             foreign_key: :creator_id,
             inverse_of: :wishlist_items
  has_one :house,
          through: :wishlist,
          inverse_of: :wishlist_items

  validates :title, presence: true
end
