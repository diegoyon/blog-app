class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @author = Author.find_by(id: params[:author_id])
    @comment = Comment.new(
      text: params[:comment][:text],
      post_id: @post.id,
      author_id: @author.id
    )
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id]).destroy
    @post = Post.find_by(id: params[:post_id])
    respond_to do |format|
      format.html do
        redirect_back_or_to author_post_path(current_author, @post), notice: 'Comment was successfully deleted.'
      end
    end
  end
end
