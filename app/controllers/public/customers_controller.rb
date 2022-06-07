class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit]
  
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customers_path(@customer)
      flash[:notice] = "プロフィールを変更しました"
    else
      render "edit"
    end
  end
  
  def unsubscribe
  end
  
  
  def withdrawal
    @customer = Customer.find(params[:id])
    if @customer.update(is_deleted: true)
      reset_session #セッション情報を全て削除
      flash[:notice] = "退会いたしました。ご利用ありがとうございました。"
      redirect_to root_path
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image)
  end
  
  #ゲストユーザはプロフィール編集画面へ遷移できないようにする
  def ensure_guest_customer 
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customers_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
end
