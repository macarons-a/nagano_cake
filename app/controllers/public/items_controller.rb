class Public::ItemsController < ApplicationController
  def index
    if params[:name].nil?
      @items = Item.all
      @paginate_items = @items.page(params[:page]).per(8)
    else
      @items = Genre.find_by(name: params[:name]).items
      @paginate_items = @items.page(params[:page]).per(8)
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
