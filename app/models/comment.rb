class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :post

  def update_comments_counter
    post.update(comments_counter: post.comments.length)
  end
end
