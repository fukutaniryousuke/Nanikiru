class Customer < ApplicationRecord
  has_one_attached :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |customer|
    #パスワードはランダムな文字列
    user.password = SecureRandom.urlsafe_base64
    user.name = "guestuser"
   end
  end
  validates :name, presence: true
  
end
