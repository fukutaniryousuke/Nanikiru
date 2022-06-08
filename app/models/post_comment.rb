class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post_image
  varidates :comment, presence: true
end
