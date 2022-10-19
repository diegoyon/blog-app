class Post < ApplicationRecord
  belongs_to :author
  has_many :comments
  has_many :likes

  def update_posts_counter
    author.update(posts_counter: author.posts.length)
  end

  def five_recent_comments
    comments.last(5)
  end
end
