class Public::NotificationsController < ApplicationController

  def index
     @notifications = current_customer.passive_notifications
     @notifications.where(checked: false).each do |notification|
          notification.update(checked: true)
    notification = @notifications.where.not(visitor_id: current_customer.id)
     end
  end

   def destroy_all
      #通知を全削除
        @notifications = current_customer.passive_notifications.destroy_all
        redirect_to notifications_path
   end
end
