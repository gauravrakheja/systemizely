class House < ApplicationRecord
  belongs_to :owner,
             class_name: "User",
             inverse_of: :owned_house
end
