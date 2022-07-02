class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships,
           class_name:  "Follower", foreign_key: "follower_id",
           dependent: :destroy
  has_many :passive_relationships,
           class_name:  "Follower", foreign_key: "followed_id",
           dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true
  validates :email, presence: true

  def unfollow(followered_user)
    active_relationships.find_by(followed_id: followered_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

end
