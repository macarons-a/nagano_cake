class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!


  def show
    @order = Order.find(params[:id])
    @shipping_cost = 800
  end

  def update
    order = Order.find(params[:id])
    if order.update(order_params)
      flash[:success] = "ステータスを変更しました。"
      redirect_to admin_order_path
    else
      render :show
    end
  end
  

  private

  def order_params
    params.require(:order).permit(:status)
  end

  
end
