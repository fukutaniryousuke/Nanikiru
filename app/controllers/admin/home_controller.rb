class Admin::HomeController < ApplicationController
  def top
    @customers = Customer.all.order(created_at: :desc)
  end
end
