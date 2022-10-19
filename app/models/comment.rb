class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :post

  def update_comments_counter
    self.post.update(comments_counter: self.post.comments.length)
  end
end
