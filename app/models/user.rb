class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :followeds, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  has_many :followers, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable



  def can_follow?
    should_follow = self.followeds.pluck(:follower_id) 
    !should_follow.include?(self.id)
  end

end
