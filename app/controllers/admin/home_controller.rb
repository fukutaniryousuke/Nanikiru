class Admin::HomeController < ApplicationController
  def top
    @customers = Customer.all
  end
end
