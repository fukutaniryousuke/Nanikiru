class Admin::HomeController < ApplicationController
  def top
    @customers = Customer.all.order(created_at: :desc).page(params[:page]).per(5)
  end
end
