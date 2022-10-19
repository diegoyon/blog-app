class Post < ApplicationRecord
  after_save :update_posts_counter

  belongs_to :author
  has_many :comments
  has_many :likes

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, comparison: { greater_than_or_equal_to: 0 }

  def five_recent_comments
    comments.last(5)
  end

  private

  def update_posts_counter
    author.update(posts_counter: author.posts.length)
  end
end
