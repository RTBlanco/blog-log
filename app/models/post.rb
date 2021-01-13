class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  def like
    self.likes += 1
    self.save
  end
end