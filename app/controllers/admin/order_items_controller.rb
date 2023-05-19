class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    order = Order.find(params[:id])
    order_item = order.order_items.find(params[:id])
    if order_item.update(order_item_params)
      flash[:success] = "ステータスを変更しました。"
      redirect_to admin_order_path(order)
    else
      render :show
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end

end