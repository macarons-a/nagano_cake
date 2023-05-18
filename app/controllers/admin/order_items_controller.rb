class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    order = Order.find(params[:id])
    order.order_items.each do |order_item|
      if order_item.update(order_item_params)
        flash[:success] = "ステータスを変更しました。"
        redirect_to admin_orders_path
      else
        render :show
      end
    end
  end
  
  private
  
  def order_item_params
    params.require(:order).permit(order_items_attributes: [:making_status])
  end
  
end
