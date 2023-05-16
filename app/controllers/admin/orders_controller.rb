class Admin::OrdersController < ApplicationController
  
  def index
    @order = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def update
    order = Order.find(params[:id])
    order.update(order_params)
    order.order_items.each do |order_item|
      order_item.update(order_item_params)
    end
    flash[:success] = "ステータスを変更しました。"
    redirect_to admin_orders_path
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
  def order_item_params
    params.require(:order).permit(order_items_attributes: [:making_status])
  end
  
end
