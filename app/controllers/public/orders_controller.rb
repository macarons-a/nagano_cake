class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

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
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:delivery_type] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:delivery_type] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      if @order.form_blank? || @order.postal_code !~ /\A\d{7}\z/ #フォームが空もしくは郵便番号電話が7桁以外だとはじく
        @customer = current_customer
        @addresses = @customer.addresses
        flash[:error] = "フォームが空、もしくは郵便番号が7桁ではありません"
        render :new
      end
    end
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_items = current_customer.cart_items
    @order = current_customer.orders.new(order_params)
    if @order.save
      @cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.amount = cart.amount
        order_item.price = (cart.item.price*1.1).floor
        order_item.save
      end
      redirect_to orders_complete_path
      @cart_items.destroy_all
    else
      render :confirm
    end
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    if (params[:id] == "confirm") #注文確認画面でのページ更新時にカートに遷移させる
      redirect_to cart_items_path
    else
      @order = Order.find(params[:id])
      @cart_items = @order.order_items
    end
  end

  def complete
  end
  
  private
  def order_params
    params.require(:order).permit(:postal_code,:address, :name, :shipping_cost, :total_payment, :payment_method,:customer_id, :status)
  end

end
