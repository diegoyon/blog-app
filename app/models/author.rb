class Author < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :posts

  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }

  def three_recent_posts
    posts.last(3)
  end
end
