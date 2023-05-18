class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @addresses = @customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:delivery_type] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.last_name
    elsif params[:order][:delivery_type] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:delivery_type] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
     render :new
    end
    @cart_items = current_customer.cart_items
    @order.customer_id = current_customer.id
  end


  def create
    cart_items = current_customer.cart_items
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.amount = cart.amount
        order_item.price = (cart.item.price*1.1).floor
        order_item.save
      end
      redirect_to orders_complete_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)  #エラー出そう！
      render :confirm
    end
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @cart_items = @order.order_items
  end

  def complete
  end

  def order_params
    params.require(:order).permit(:postal_code,:address, :name, :shipping_cost, :total_payment, :payment_method,:customer_id, :status)
  end


end
