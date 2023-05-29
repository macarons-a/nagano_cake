class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!


  def show
    @order = Order.find(params[:id])
    @shipping_cost = 800
  end

  def update
    order = Order.find(params[:id])
    order_items = OrderItem.where(order_id: params[:id])
    if order.update(order_params)
      order_items.update_all(making_status: 1) if order.status == "payment_confirmation"
      flash[:success] = "ステータスを変更しました。"
      redirect_to admin_order_path
    else
      render :show
    end
  end

  def index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.page(params[:page])
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end


end
