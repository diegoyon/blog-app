class Author < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :posts

  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  def three_recent_posts
    posts.order("created_at DESC").first(3)
  end
end
