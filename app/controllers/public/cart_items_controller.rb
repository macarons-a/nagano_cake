class Public::CartItemsController < ApplicationController

  def index
  end

  def create
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
