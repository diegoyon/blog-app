class Like < ApplicationRecord
  belongs_to :author
  belongs_to :post

  def update_likes_counter
    self.post.update(likes_counter: self.post.likes.length)
  end
end
