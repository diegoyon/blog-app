class Post < ApplicationRecord
  after_save :update_posts_counter

  belongs_to :author
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  validates :likes_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  def five_recent_comments
    comments.includes([:author]).order('created_at DESC').first(5)
  end

  private

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
