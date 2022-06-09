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
  def after_sign_in_path_for(resource)
    customer_path(current_customer)
  end

  def guest_sign_in #ゲストログイン機能
    customer = Customer.guest
    sign_in customer
    redirect_to customer_path(customer), notice: "ゲストとしてログインしました"
  end
  
  def customer_state #退会しているか判断
    #入力されたemaiからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    #アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    #取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
      redirect_to new_customer_registration_path
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
