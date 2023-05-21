# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])

    if @customer && @customer.valid_password?(params[:customer][:password])
      if @customer.is_deleted?
        flash[:danger] = "退会済みのアカウントです。ログインできません。"
        redirect_to new_customer_registration_path
      else
        sign_in(@customer)
        flash[:notice] = "ログインしました。"
        redirect_to root_path
      end
    end
  end

end
