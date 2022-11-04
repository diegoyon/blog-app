class Api::V1::CommentsController < Api::V1::ApplicationController
  def create
    post = Post.find_by(id: params[:post_id])
    author = Author.find_by(id: params[:author_id])
    comment = Comment.new(
      text: params[:comment][:text],
      post_id: post.id,
      author_id: author.id
    )
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end
end
