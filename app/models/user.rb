class User < ActiveRecord::Base 
  has_secure_password

  validates :name, presence: true

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users

  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  has_many :posts

  def follow(user)
    self.followees << user
    self.save
  end

  def unfollow(user)
    self.followees.delete(user)
    user.followers.delete(self)
    self.save
    user.save
  end
end