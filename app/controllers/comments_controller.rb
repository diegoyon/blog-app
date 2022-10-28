class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new(
      text: params[:comment][:text],
      post_id: @post.id,
      author_id: current_user.id
    )
    if @comment.save
      redirect_to author_post_path(current_user, @post)
    else
      render :new
    end
  end
end
