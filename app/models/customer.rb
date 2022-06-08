class Customer < ApplicationRecord
  has_one_attached :profile_image
  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |customer|
    #パスワードはランダムな文字列
    customer.password = SecureRandom.urlsafe_base64
    customer.name = "guestuser"
   end
  end
  
  validates :name, presence: true
  validates :email, presence: true
end
