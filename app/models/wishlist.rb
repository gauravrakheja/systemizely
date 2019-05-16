class Wishlist < ApplicationRecord
  belongs_to :house, inverse_of: :wishlist
  has_many :wishlist_items, inverse_of: :wishlist
end
