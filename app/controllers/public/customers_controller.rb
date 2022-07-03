class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit, :unsubscribe]
  before_action :ensure_customer, only: [:edit, :update, :unsubscribe, :withdrawal]

  def show
    @customer = Customer.find(params[:id])
    @post_images = @customer.post_images.all.order(created_at: :desc)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
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

  def favorites
    favorites = Favorite.where(customer_id: current_customer.id).pluck(:post_image_id)
    @favorite_post_images = PostImage.where(id: favorites)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image)
  end

  #ゲストユーザはプロフィール編集画面へ遷移できないようにする
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to customer_path(current_customer)
    end
  end

end
