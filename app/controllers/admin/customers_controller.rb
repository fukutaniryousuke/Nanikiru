class Admin::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @post_images = @customer.post_images.all.order(created_at: :desc)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  # 会員情報を変更する
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
      flash[:notice] = "会員情報を変更しました"
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted, :profile_image)
  end
end
