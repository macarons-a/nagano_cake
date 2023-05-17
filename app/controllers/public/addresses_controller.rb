class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
    @address = Address.new
    @addresses = @customer.addresses
  end

  def create
    @address = current_customer.addresses.build(address_params)
    if @address.save
      flash[:notice] = "配送先を追加しました"
      redirect_to request.referer
    else
      @customer = current_customer
      @addresses = @customer.addresses
      render :new
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "配送先を変更しました"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:notice] = "配送先を削除しました"
    redirect_to request.referer
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
