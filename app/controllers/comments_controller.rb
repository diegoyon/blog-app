class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new(
      text: params[:comment][:text],
      post_id: @post.id,
      author_id: current_author.id
    )
    if @comment.save
      redirect_back_or_to author_post_path(current_author, @post)
    else
      render :new
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
