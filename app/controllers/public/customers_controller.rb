class Public::CustomersController < ApplicationController
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
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image)
  end
end
