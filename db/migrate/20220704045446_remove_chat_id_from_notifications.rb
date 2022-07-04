class RemoveChatIdFromNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :chat_id, :integer
  end
end
