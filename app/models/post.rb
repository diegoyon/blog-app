class Post < ApplicationRecord
  belongs_to :author
  has_many :comments
  has_many :likes

  def update_posts_counter
    self.author.update(posts_counter: self.author.posts.length)
  end

  def five_recent_comments
    self.comments.last(5)
  end
end
