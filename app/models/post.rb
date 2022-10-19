class Post < ApplicationRecord
  after_save :update_posts_counter

  belongs_to :author
  has_many :comments
  has_many :likes

  def five_recent_comments
    comments.last(5)
  end

  private

  def update_posts_counter
    author.update(posts_counter: author.posts.length)
  end
end
