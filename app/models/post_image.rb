class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  
  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
end
