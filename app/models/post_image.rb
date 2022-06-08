class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
end
