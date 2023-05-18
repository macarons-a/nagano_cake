class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @total_payment = @order.pirce.subtotal
    @shipping_cost = 800
  end

  def update
    order = Order.find(params[:id])
    if order.update(order_params)
      flash[:success] = "ステータスを変更しました。"
      redirect_to admin_orders_path
    else
      render :show
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
  
end
