class Api::V1::CommentsController < Api::V1::ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:text)
      .with_defaults(author_id: current_author.id, post_id: params[:post_id])
  end
end
