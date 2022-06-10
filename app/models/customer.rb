class Customer < ApplicationRecord
  has_one_attached :profile_image
  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォローしている人取得
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォローされている人取得
  has_many :followings, through: :relationships, source: :followed #自分がフォーローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower #自分をフォーローしている人
  has_many :customer_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :customer_rooms, dependent: :destroy
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

  #ユーザーをフォローする
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  #ユーザーのフォローを外す
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  #フォロー確認を行う
  def following?(customer)
    followings.include?(customer)
  end

  validates :name, presence: true
  validates :email, presence: true
end
