class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_item = OrderItem.find(params[:id])
    orders = @order_item.order
    order_items = orders.order_items.all
    
    
    is_updated = true
    if @order_item.update(order_item_params)
      orders.update(status: 2) if @order_item.making_status == "is_making"
      
      order_items.each do |order_item|
        if order_item.making_status != "completion"
          is_updated = false
        end
      end
      orders.update(status: 3) if is_updated
      flash[:success] = "ステータスを変更しました。"
      redirect_to admin_order_path(orders)
    else
      render :show
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end

end