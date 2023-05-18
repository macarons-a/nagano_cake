class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @addresses = @customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:my_address] == "0"
      @order.shipping_post_code = current_ccustomer.post_code
      @order.shipping_address = current_ccustomer.address
      @order.shipping_name = current_ccustomer.last_name + current_customer.last_name
    elsif params[:order][:existing_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @order.name
    elsif params[:order][:new_address] = "2"
      @order.post_code = params[:order][:post_code]
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
        order_item.order_amount = cart.amount
        ordered_item.tax_included_price = (cart.item.price*1.1).floor
        order_item.save
      end
      redirect_to　orders_complete_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :confirm
    end
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
