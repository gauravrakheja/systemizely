class WishlistItemsController < ApplicationController
  def create
    @wishlist_item = WishlistItem.new(wishlist_item_params)
    if @wishlist_item.save
      flash[:success] = "Wishlist Item created"
    else
      flash[:danger] = "Wishlist Item could not be created"
    end
    redirect_back(fallback_location: new_wishlist_path)
  end

  def update
    @wishlist_item = WishlistItem.find(params[:id])
    if @wishlist_item.update(wishlist_item_params)
      flash[:success] = "Wishlist Item updated"
    else
      flash[:danger] = "Wishlist Item could not be updated"
    end
    redirect_back(fallback_location: new_wishlist_path)
  end

  def destroy
    @wishlist_item = WishlistItem.find(params[:id])
    if @wishlist_item.destroy
      flash[:success] = "Wishlist Item removed"
    else
      flash[:danger] = "Wishlist Item could not be removed"
    end
    redirect_back(fallback_location: new_wishlist_path)
  end

  private

  def wishlist_item_params
    params.require(:wishlist_item)
      .permit(
        :creator_id,
        :wishlist_id,
        :title,
        :buy_by,
        :cost,
        :link,
        :title
      )
  end
end