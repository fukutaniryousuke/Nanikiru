class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def create_notification_by(current_customer)
    notification = current_customer.active_notifications.new(
      post_image_id: id,
      visited_id: customer_id,
      action: "favorite"
      )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_customer, post_comment_id)
    temp_ids = PostComment.select(:customer_id).where(post_image_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_customer, post_comment_id, temp_id["customer_id"])
    end

    save_notification_comment!(current_customer, post_comment_id, customer_id) 
  end

  def save_notification_comment!(current_customer, post_comment_id, visited_id)
    notification = current_customer.active_notifications.new(
      post_image_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: "post_comment"
      )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
