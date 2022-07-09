class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :post_image, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :visiter, class_name: "Customer", optional: true
  belongs_to :visited, class_name: "Customer", optional: true
end
