class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @addresses = @customer.addresses
  end

  def create
    cart_items = current_customer.cart_items
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.order_quantity = cart.quantity
        order_item.order_price = cart.item.price # 税込み？税抜き？
        order_item.save
      end
      redirect_to　order
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end


  def confirm
  end


  def index
  end

  def show
  end

  def complete
  end

  def order_params
    params.require(:order).permit(:postal_code,:address, :name, :shipping_cost, :total_payment, :payment_method,:customer_id, :status)
  end


end
