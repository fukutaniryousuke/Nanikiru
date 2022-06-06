class Customer < ApplicationRecord
  has_one_attached :profile_image
  #before_action :ensure_guest_customer, only: [:edit]
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
  # def ensure_guest_customer
  #   @customer = Customer.find(params[:id])
  #   if @customer.name == "guestuser"
  #     redirect_to customers_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
  #   end
  # end  
  validates :name, presence: true
  
end
