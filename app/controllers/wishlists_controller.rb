class WishlistsController < ApplicationController
  include UsersHelper
  before_action :check_current_house, only: %i[show]

  def new
    @wishlist = current_house.wishlist || current_house.create_wishlist
  end
end