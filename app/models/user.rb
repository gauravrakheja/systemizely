class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :owned_houses,
           class_name: "House",
           inverse_of: :owner,
           foreign_key: :owner_id
end
