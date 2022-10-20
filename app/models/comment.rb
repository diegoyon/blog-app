class Comment < ApplicationRecord
  after_save :update_comments_counter

  belongs_to :author
  belongs_to :post

  private

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
