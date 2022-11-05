class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_back_or_to author_post_path(current_author, params[:post_id]), notice: 'Comment was successfully created.'
    else
      redirect_back_or_to author_post_path(current_author, params[:post_id]), notice: 'Error creating the comment.'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    respond_to do |format|
      format.html do
        redirect_back_or_to author_post_path(current_author, params[:post_id]), notice: 'Comment was successfully deleted.'
      end
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
