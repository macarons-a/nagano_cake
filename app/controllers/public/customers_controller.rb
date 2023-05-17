class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if  @customer.update(customer_params)
      flash[:notice] = "会員情報を変更しました"
      redirect_to customer_path
    else
      render:edit
    end
  end

  def withdraw_confirm
  end

  def withdraw
  end


  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number, :email, :is_deleted)
  end
end
