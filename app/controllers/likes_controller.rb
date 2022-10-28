class LikesController < ApplicationController

  def new
    @like = Like.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @like = Like.new(
      post_id: @post.id,
      author_id: current_user.id
    )
    if @like.save
      redirect_to author_post_path(current_user, @post)
    else
      render :new
    end
  end
end
