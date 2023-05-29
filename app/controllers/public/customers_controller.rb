class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
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
      redirect_to customers_path
    else
      render :edit
    end
  end

  def withdraw_confirm
    @customer = current_customer
  end

  def withdraw
    customer = current_customer
    if params[:commit] == "退会する"
      customer.update(is_deleted: true)
      sign_out(customer)
      flash[:notice] = "退会処理が完了しました。ご利用ありがとうございました。"
      redirect_to root_path
    elsif params[:commit] == "退会しない"
      flash[:notice] = "退会処理がキャンセルされました。"
      redirect_to customers_path
    end
  end


  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number, :email, :is_deleted)
  end

end
