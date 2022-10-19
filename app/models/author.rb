class Author < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :posts

  def three_recent_posts
    self.posts.last(3)
  end
end
