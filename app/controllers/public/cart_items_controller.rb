class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total_payment = 0
  end

  def create
    item = Item.find(params[:cart_item][:item_id])
    cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: item.id)
    unless cart_item.nil?
      byebug
      cart_item.amount += (params[:cart_item][:amount]).to_i
      cart_item.update(cart_item_params)
      flash[:notice] = "カート内商品の数量を追加しました"
      redirect_to request.referer
    else
      cart_item = current_customer.cart_items.new(cart_item_params)
      cart_item.save
      flash[:notice] = "カートに商品を追加しました"
      redirect_to request.referer
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    flash[:notice] = "数量を変更しました"
    redirect_to request.referer
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to request.referer
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to request.referer
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
